import 'package:bookapp/common/color_extenstion.dart';
import 'package:bookapp/view/book_reading/book_reading_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../common_widget/best_seller_cell.dart';
import '../../common_widget/genres_cell.dart';
import '../../common_widget/recently_cell.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import '../../common_widget/top_picks_cell.dart';
import '../login/sign_up_view.dart';
import '../main_tab/main_tab_view.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController txtUserName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();

  final List<Map<String, dynamic>> topPicksArr = [
    {"name": "Harry Potter", "author": "J.K. Rowling", "img": "assets/img/1.jpg"},
    {"name": "The Time Travel Diaries", "author": "Caroline Lawrence", "img": "assets/img/3.jpg"},
    {"name": "The Disappearance of Emila Zola", "author": "Michael Rosen", "img": "assets/img/2.jpg"},
  ];

  final List<Map<String, dynamic>> bestArr = [
    {"name": "The Magic of Lost Story", "author": "Sudha Murty", "img": "assets/img/4.jpg", "rating": 5.0, "wishlist": false},
    {"name": "Believe in Yourself", "author": "Joseph Murphy", "img": "assets/img/5.jpg", "rating": 4.0, "wishlist": false},
    {"name": "The Name of the Wind", "author": "Patrick Rothfuss", "img": "assets/img/6.jpg", "rating": 3.0, "wishlist": false},
  ];

  final List<Map<String, dynamic>> genresArr = [
    {"name": "Graphic Novels", "img": "assets/img/g1.png"},
    {"name": "Mystery Novels", "img": "assets/img/g2.jpg"},
    {"name": "Science Fiction", "img": "assets/img/g3.jpeg"},
  ];

  final List<Map<String, dynamic>> recentArr = [
    {"name": "The Fatal Tree", "author": "Jake Arnott", "img": "assets/img/10.jpg"},
    {"name": "Day Four", "author": "Sarah Lotz", "img": "assets/img/11.jpg"},
    {"name": "Door to Door", "author": "Edward Humes", "img": "assets/img/12.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;



    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  child: Transform.scale(
                    scale: 1.5,
                    origin: Offset(0, media.width * 0.8),
                    child: Container(
                      width: media.width,
                      height: media.width,
                      decoration: BoxDecoration(
                        color: TColor.primary,
                        borderRadius: BorderRadius.circular(media.width * 0.5),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: media.width * 0.1),
                    _buildAppBar(),
                    _buildCarousel(media),
                    _buildSectionTitle("Bestsellers", media),
                    _buildBestSellerList(media),
                    _buildSectionTitle("Genres", media),
                    _buildGenresList(media),
                    _buildSectionTitle("Recently Viewed", media),
                    _buildRecentlyViewedList(media),
                    _buildNewsletterSection(media),
                    SizedBox(height: media.width * 0.1),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        "Our Top Picks",
        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
      ),
      leading: Container(),
      leadingWidth: 1,
      actions: [
        IconButton(
          onPressed: () {
            sideMenuScaffoldKey.currentState?.openEndDrawer();
          },
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildCarousel(Size media) {
    return SizedBox(
      width: media.width,
      height: media.width * 0.8,
      child: CarouselSlider.builder(
        itemCount: topPicksArr.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          var iObj = topPicksArr[itemIndex];
          return TopPicksCell(iObj: iObj);
        },
        options: CarouselOptions(
          autoPlay: false,
          aspectRatio: 1,
          enlargeCenterPage: true,
          viewportFraction: 0.45,
          enlargeFactor: 0.4,
          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Size media) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: TextStyle(color: TColor.text, fontSize: 22, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildBestSellerList(Size media) {
    return SizedBox(
      height: media.width * 0.9,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: bestArr.length,
        itemBuilder: (context, index) {
          var bObj = bestArr[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookReadingView(bObj: bObj)),
              );
            },
            child: BestSellerCell(
              bObj: bObj,
              onWishlistToggle: () {
                setState(() {
                  bObj['wishlist'] = !bObj['wishlist'];
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildGenresList(Size media) {
    return SizedBox(
      height: media.width * 0.6,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: genresArr.length,
        itemBuilder: (context, index) {
          var bObj = genresArr[index];
          return GenresCell(
            bObj: bObj,
            bgcolor: index % 2 == 0 ? TColor.color1 : TColor.color2,
          );
        },
      ),
    );
  }

  Widget _buildRecentlyViewedList(Size media) {
    return SizedBox(
      height: media.width * 0.7,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: recentArr.length,
        itemBuilder: (context, index) {
          var bObj = recentArr[index];
          return RecentlyCell(iObj: bObj);
        },
      ),
    );
  }

  Widget _buildNewsletterSection(Size media) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monthly Newsletter",
            style: TextStyle(color: TColor.text, fontSize: 22, fontWeight: FontWeight.w700),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: TColor.textbox.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Receive our monthly newsletter with updates on new books and promotions.",
                  style: TextStyle(color: TColor.subTitle, fontSize: 12),
                ),
                const SizedBox(height: 15),
                RoundTextField(
                  controller: txtUserName,
                  hintText: "Name",
                  onChanged: (value) {},
                ),
                const SizedBox(height: 15),
                RoundTextField(
                  controller: txtEmail,
                  hintText: "Email Address",
                  onChanged: (value) {},
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MiniRoundButton(
                      title: "Sign Up",
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpView()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}