const { Pool } = require("pg");
const jwt = require("jsonwebtoken");
const nodemailer = require("nodemailer");
const crypto = require("crypto");
const multer = require("multer");
const path = require("path");

const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "bookapp",
  password: "admin",
  port: 5432,
});

// Set up multer for file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/'); // Save files in 'uploads' folder
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname)); // Unique file name
  }
});

const upload = multer({ storage: storage });

// Register User
const signupUser = async (request, response) => {
  const { username, email, mobile, city, password } = request.body;
  try {
    await pool.query(
      'INSERT INTO "signup" (username, email, mobile, city, password) VALUES ($1, $2, $3, $4, $5)',
      [username, email, mobile, city, password]
    );
    response.status(200).send("User added successfully");
  } catch (error) {
    console.error("Error signing up:", error.message);
    response.status(500).send("Error signing up user");
  }
};

// Login User
const loginUser = async (req, res) => {
  const { email, password } = req.body;
  try {
    const result = await pool.query('SELECT * FROM "signup" WHERE email = $1', [email]);
    if (result.rows.length === 0) {
      return res.status(400).json({ message: "User not found" });
    }
    const user = result.rows[0];
    if (password !== user.password) {
      return res.status(400).json({ message: "Invalid password" });
    }

    const token = jwt.sign({ userId: user.id }, "your_jwt_secret", { expiresIn: "1h" });
    res.status(200).json({
      message: "Login successfully!",token,
      user: {
        username: user.username,
        city: user.city,
        profile_image: user.profile_image,
      },
    });
    // print($username,city);
  } catch (error) {
    console.error("Login failed:", error);
    res.status(500).json({ message: "Login failed", error });
  }
};

// Send Verification Code for Password Reset
const sendVerificationCode = async (request, response) => {
  const { email } = request.body;
  try {
    // Check if email exists
    const user = await pool.query('SELECT * FROM "signup" WHERE email = $1', [email]);
    if (user.rows.length === 0) {
      return response.status(404).send("Email not registered");
    }

    // Generate code and expiry
    const verificationCode = crypto.randomInt(1000, 9999).toString();
    const expiryTime = new Date(Date.now() + 10 * 60 * 1000); // 10 minutes

    await pool.query(
      'INSERT INTO "password_resets" (email, verification_code) VALUES ($1, $2)',
      [email, verificationCode]
    );

    let transporter = nodemailer.createTransport({
      host: "smtp.gmail.com",
      port: 465,
      secure: true,
      auth: {
        user: 'gyasuddinansari7854@gmail.com',
        pass: 'pbarxwgalrvfcblg',
      },
    });

    let mailOptions = {
      from: 'gyasuddinansari7854@gmail.com',
      to: email,
      subject: "Password Forget Verification Code",
      text: `Your verification code is: ${verificationCode}. This code will expire in 10 minutes.`,
    };

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.error("Error sending email:", error);
        return response.status(500).send("Error sending verification code");
      }
      response.status(200).send("Verification code sent to email");
    });
  } catch (error) {
    console.error("Error sending verification code:", error);
    response.status(500).send("Error processing request");
  }
};

// Reset Password
const resetPassword = async (request, response) => {
  const { email, verificationCode, newPassword } = request.body;
  try {
    const result = await pool.query(
      'SELECT * FROM "password_resets" WHERE email = $1',
      [email, verificationCode]
    );

    if (result.rows.length === 0) {
      return response.status(400).send("Invalid or expired verification code");
    }

    const hashedPassword = await bcrypt.hash(newPassword, 10);

    await pool.query(
      'UPDATE "signup" SET password = $1 WHERE email = $2',
      [hashedPassword, email]
    );

    await pool.query('DELETE FROM "password_resets" WHERE email = $1', [email]);
    response.status(200).send("Password reset successfully");
  } catch (error) {
    console.error("Error resetting password:", error);
    response.status(500).send("Error resetting password");
  }
};

// update profile
const updateProfile = async (request, response) => {
  const { username, city, email } = request.body;
  const profileImage = request.file ? request.file.filename : null;

  try {
    await pool.query(
      `UPDATE "signup" 
       SET username = $1, city = $2, profile_image = COALESCE($3, profile_image) 
       WHERE email = $4`,
      [username, city, profileImage, email]
    );

    const updatedUser = await pool.query(
      'SELECT username, city, profile_image FROM "signup" WHERE email = $1',
      [email]
    );

    response.status(200).json({
      message: "Profile updated successfully",
      updatedProfile: updatedUser.rows[0],
    });
  } catch (error) {
    console.error("Error updating profile:", error);
    response.status(500).send("Error updating profile");
  }
};


// Add to Wishlist (Updated to include description and image_path)
const addToWishlist = async (req, res) => {
  const { user_id, book_name, book_writer, description, image_path } = req.body;

  try {
    const result = await pool.query(
      'INSERT INTO wishlist_view (user_id, book_name, book_writer, description, image_path) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [user_id, book_name, book_writer, description, image_path]
    );
    res.status(201).json({ message: "Book added to wishlist", item: result.rows[0] });
  } catch (error) {
    console.error("Error adding to wishlist:", error);
    res.status(500).json({ message: "Error adding to wishlist" });
  }
};

const getWishlist = async (req, res) => {
  const { user_id } = req.params;

  try {
    const result = await pool.query(
      'SELECT * FROM wishlist_view WHERE user_id = $1',
      [user_id]
    );
    res.status(200).json({ wishlist: result.rows });
  } catch (error) {
    console.error("Error retrieving wishlist:", error);
    res.status(500).json({ message: "Error retrieving wishlist" });
  }
};

const removeFromWishlist = async (req, res) => {
  const { id } = req.params;

  try {
    await pool.query('DELETE FROM wishlist_view WHERE id = $1', [id]);
    res.status(200).json({ message: "Book removed from wishlist" });
  } catch (error) {
    console.error("Error removing from wishlist:", error);
    res.status(500).json({ message: "Error removing from wishlist" });
  }
};

module.exports = {
  signupUser,
  loginUser,
  sendVerificationCode,
  resetPassword,
  updateProfile,
  addToWishlist,
  getWishlist,
  removeFromWishlist,
  upload,
};
