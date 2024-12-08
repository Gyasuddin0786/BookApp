import 'package:bookapp/common/color_extenstion.dart';
import 'package:bookapp/our_store/our_book_store.dart';
import 'package:bookapp/view/account/privacy_terms_controller.dart';
import 'package:bookapp/view/book_reading/continious_reading.dart';
import 'package:bookapp/view/our_book/wishlist.dart';
import 'package:flutter/material.dart';
import '../account/account_view.dart';
import '../book_reading/book_reading_view.dart';
import '../home/home_view.dart';
import '../our_book/out_books_view.dart';
import '../search/search_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

GlobalKey<ScaffoldState> sideMenuScaffoldKey = GlobalKey<ScaffoldState>();

class _MainTabViewState extends State<MainTabView>
    with TickerProviderStateMixin {
  TabController? controller;

  int selectMenu = 0;

  List menuArr = [
    {"name": "Home", "icon": Icons.home},
    {"name": "Our Books", "icon": Icons.book},
    {"name": "Our Stores", "icon": Icons.storefront},
    {"name": "Wishlist", "icon": Icons.favorite},
    {"name": "Learning", "icon": Icons.menu_book},
    {"name": "Dowload Pdf ", "icon": Icons.picture_as_pdf},
    {"name": "Account", "icon": Icons.account_circle}
  ];

  @override
  void initState() {
    controller = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      key: sideMenuScaffoldKey,
      endDrawer: Drawer(
        backgroundColor: const Color.fromARGB(0, 255, 254, 254),
        elevation: 0,
        width: media.width * 0.8,
        child: Container(
          decoration: BoxDecoration(
              color: TColor.dColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(media.width * 0.7),
              ),
              boxShadow: const [
                BoxShadow(color: Colors.black54, blurRadius: 15)
              ]),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: menuArr.map((mObj) {
                      var index = menuArr.indexOf(mObj);
                      return Container(
                        // margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        decoration: selectMenu == index
                            ? BoxDecoration(color: TColor.primary, boxShadow: [
                                BoxShadow(
                                    color: TColor.primary,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3))
                              ])
                            : null,
                        child: GestureDetector(
                          onTap: () {
                            if (index == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OurBooksView()));
                              sideMenuScaffoldKey.currentState
                                  ?.closeEndDrawer();
                            } else if (index == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OurBookStore()));
                              sideMenuScaffoldKey.currentState
                                  ?.closeEndDrawer();
                            } else if (index == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WishlistView()));
                              sideMenuScaffoldKey.currentState
                                  ?.closeEndDrawer();
                            } else if (index == 4) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ContinuousReading()));
                              sideMenuScaffoldKey.currentState
                                  ?.closeEndDrawer();
                            } else if (index == 5) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BookReadingView(
                                            bObj: {},
                                          )));
                              sideMenuScaffoldKey.currentState
                                  ?.closeEndDrawer();
                            } else if (index == 6) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AccountView()));
                              sideMenuScaffoldKey.currentState
                                  ?.closeEndDrawer();
                            }

                            //

                            setState(() {
                              selectMenu = index;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                mObj["name"].toString(),
                                style: TextStyle(
                                    color: selectMenu == index
                                        ? Colors.white
                                        : TColor.text,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Icon(
                                mObj["icon"] as IconData? ?? Icons.home,
                                color: selectMenu == index
                                    ? Colors.white
                                    : TColor.primary,
                                size: 33,
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList()),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.settings,
                            color: TColor.subTitle,
                            size: 25,
                          )),
                      const SizedBox(
                        width: 15,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Terms",
                          style: TextStyle(
                              color: TColor.subTitle,
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PrivacyTerms()));
                        },
                        child: Text(
                          "Privacy",
                          style: TextStyle(
                              color: TColor.subTitle,
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(controller: controller, children: [
        const HomeView(),
        const SearchView(),
        const WishlistView(),
        const AccountView(),
        Container(),
        Container(),
        Container(),
      ]),
      bottomNavigationBar: BottomAppBar(
        color: TColor.primary,
        child: TabBar(
            controller: controller,
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            tabs: const [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.favorite_border),
                text: "Wishlist",
              ),
              Tab(
                icon: Icon(Icons.account_circle),
                text: "Profile",
              ),
            ]),
      ),
    );
  }
}