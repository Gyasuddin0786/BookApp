const express = require("express");
const bodyParser = require('body-parser');
// const cors = require('cors');
const { signupUser, loginUser, sendVerificationCode, resetPassword, updateProfile,addToWishlist, getWishlist, removeFromWishlist, upload } = require("./authController");

const app = express();
app.use(express.json());

// Middleware
// app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.post("/signup", signupUser);
app.post("/login", loginUser);
app.post("/forgotpassword", sendVerificationCode);
app.post("/resetpassword", resetPassword);
app.post('/wishlist', addToWishlist);          // Add to wishlist
app.get('/wishlist/:user_id', getWishlist);    // Get wishlist
app.delete('/wishlist/:id', removeFromWishlist); // Remove from wishlist
app.put('/updateprofile', upload.single('profile_image'), updateProfile);

const port = 5454;
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
