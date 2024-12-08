import 'package:flutter/material.dart';

class ContinuousReading extends StatefulWidget {
  const ContinuousReading({super.key});

  @override
  State<ContinuousReading> createState() => _ContinuousReadingState();
}

class _ContinuousReadingState extends State<ContinuousReading> {  
  List<String> imageArr = [
    "assets/img/krishna.jpg",
    "assets/img/life.jpg",
    "assets/img/draw.jpg",
    "assets/img/uu.jpg",

  ];
  
  List<String> titleArr = [
    "Krishna ",
    "Little Book of Life",
    "Deception Point",
    "Zoo"

  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 12, 154, 144),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),

              // Reading Now section
              const Text(
                "Reading Now",
                style: TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10),
              
              // Full-width image and progress bar
              Column(
                children: [
                  Image.asset(
                    'assets/img/re.jpg', // Replace with the correct image
                    width: double.infinity, // Full width
                    height: 200, // Adjust height as needed
                    fit: BoxFit.cover, // Cover the full width while maintaining aspect ratio
                  ),
                  const SizedBox(height: 10), // Small spacing before the progress bar

                  // Progress bar
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.46, // 46% progress
                          backgroundColor: Colors.grey[300],
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),

                  const SizedBox(height: 10), // Small spacing before the percentage

                  // Percentage below the progress bar
                  const Text(
                    "36%", // Updated percentage value
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20),

              // Recently Opened Section
              const Text(
                "Recently Opened",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 220, // Increased the height for larger images
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageArr.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            imageArr[index],
                            height: 160, // Adjusted size to fit design
                            width: 110,  // Adjusted width for a balanced look
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            titleArr[index],
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ), // Added titles for each book
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
