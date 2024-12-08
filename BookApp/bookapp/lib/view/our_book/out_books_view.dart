import 'package:flutter/material.dart';

class OurBooksView extends StatefulWidget {
  const OurBooksView({super.key});

  @override
  State<OurBooksView> createState() => _OurBooksViewState();
}

class _OurBooksViewState extends State<OurBooksView> {
  List imageArr = [
    "assets/img/book1.jpg",
    "assets/img/book2.jpg",
    "assets/img/ob1.jpg"
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  "assets/img/our_books_top.png",
                  width: media.width,
                  fit: BoxFit.fitWidth,
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: media.height * 0.24), // Adjust this value to move the images down
                  child: Column(
                    children: [
                      SizedBox(
                        height: media.width * 0.5, // Increased height of the slider
                        child: PageView.builder(
                          onPageChanged: (index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          itemCount: imageArr.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  imageArr[(index) % imageArr.length],
                                  height: 150, // Increased image height
                                  width: media.width * 0.3, // Adjusted width for better fit
                                  fit: BoxFit.cover,
                                ),
                                Image.asset(
                                  imageArr[(index + 1) % imageArr.length],
                                  height: 150, // Increased image height
                                  width: media.width * 0.3,
                                  fit: BoxFit.cover,
                                ),
                                Image.asset(
                                  imageArr[(index + 2) % imageArr.length],
                                  height: 150, // Increased image height
                                  width: media.width * 0.3,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageArr.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => setState(() {
                              currentIndex = entry.key;
                            }),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == entry.key
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              
              
              
              ],

            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Text(
                """Discover a world of endless stories at your fingertips with our online reading book store app, offering a vast library of genres to suit every reader’s taste.
Enjoy a seamless reading experience with customizable features like adjustable font sizes, night mode, and bookmarks to pick up right where you left off.
Stay connected with your favorite authors and receive personalized recommendations based on your reading habits, helping you find new books you'll love.
Join a community of avid readers, where you can leave reviews, discuss books, and share your reading journey with friends and fellow book lovers.
With offline access, you can download and read your books anytime, anywhere, making sure your next great read is always within reach.""",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700], fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
