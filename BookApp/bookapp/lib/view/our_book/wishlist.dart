import 'package:bookapp/common/color_extenstion.dart'; // Import your color extension
import 'package:flutter/material.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  // Define a list to track which books' descriptions are expanded
  List<bool> isReadMoreExpanded = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: TColor.primary,
          ),
        ),
        title: const Text('Wishlist', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Column(
                children: List.generate(4, (index) {
                  String imagePath = '';
                  String title = '';
                  String author = '';
                  String description = '';

                  // Define image paths and book details
                  if (index == 0) {
                    imagePath = 'assets/img/5.jpg';
                    title = 'Believe in Yourself';
                    author = 'Joseph Murphy';
                    description =
                        'A self-help classic that explores the power of the subconscious mind. '
                        'In this book, you will learn how to harness the power of your subconscious for success in life.';
                  } else if (index == 1) {
                    imagePath = 'assets/img/w2.jpg';
                    title = 'India\'s Wars';
                    author = 'Air Vice Marshal Arjun Subramaniam';
                    description =
                        'An engaging narrative about India\'s major wars from 1947 to 1971. '
                        'A must-read for military history enthusiasts.';
                  } else if (index == 2) {
                    imagePath = 'assets/img/w3.jpg';
                    title = 'The Secret to Your Success';
                    author = 'Joseph Hensch';
                    description =
                        'Discover the simple truths to achieve success in any field. '
                        'This book provides practical tips for achieving long-term success.';
                  } else {
                    imagePath = 'assets/img/w4.jpg'; // New image added here
                    title = 'The Power of Positive Habit';
                    author = 'Charles Duhigg';
                    description =
                        'A compelling exploration of the science behind habits and how they can change our lives. '
                        'Duhigg explains how we can rewire our brain for better habits.';
                  }

                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                imagePath,
                                width: 80,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    author,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    // Show full description if 'Read More' is clicked, otherwise show just two lines
                                    isReadMoreExpanded[index]
                                        ? description
                                        : '${description.substring(0, 50)}...',
                                    maxLines: isReadMoreExpanded[index] ? null : 2,
                                    overflow: isReadMoreExpanded[index]
                                        ? TextOverflow.visible
                                        : TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            // Toggle the 'Read More' state
                                            isReadMoreExpanded[index] =
                                                !isReadMoreExpanded[index];
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF45DECB), // Set button color
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                        ),
                                        child: Text(
                                          isReadMoreExpanded[index]
                                              ? 'Read Less'
                                              : 'Read More',
                                          style: const TextStyle(fontSize: 12,color: Colors.white),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      );
    
    
  }
}
