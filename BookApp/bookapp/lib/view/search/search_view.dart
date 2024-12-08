// ignore: unused_import
import 'package:bookapp/common/extenstion.dart';
import 'package:bookapp/common_widget/history_cell.dart';
import 'package:bookapp/view/search/search_details.dart';
import 'package:bookapp/view/search/search_fiter_view.dart';
import 'package:bookapp/view/search/search_force_view.dart';
import 'package:flutter/material.dart';

import '../../common/color_extenstion.dart';
import '../../common_widget/search_grid_cell.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController txtSearch = TextEditingController();
  int selectTag = 0;

  List tagsArr = ["Genre", "New Release", "The Anime", "The Art"];
  List searchArr = [
    {"name": "Biography", "img": "assets/img/b1.jpg"},
    {"name": "Business", "img": "assets/img/b2.jpg"},
    {"name": "Children", "img": "assets/img/b3.jpg"},
    {"name": "Cookery", "img": "assets/img/b4.jpg"},
    {"name": "Fiction", "img": "assets/img/b5.jpg"},
    {"name": "Graphic Novels", "img": "assets/img/b6.jpg"},
  ];

  List sResultArr = [
    {
      "name": "The Heart of Hell",
      "img": "assets/img/h1.jpg",
      "author": "Mitch Weiss",
      "description": "The untold story of courage and sacrifice in the shadow of Iwo Jima.",
      "rate": 5.0
    },
    {
      "name": "Adrennes 1944",
      "img": "assets/img/h2.jpg",
      "author": "Antony Beevor",
      "description": "#1 international bestseller and award-winning history book.",
      "rate": 4.0
    },
    {
      "name": "War on the Gothic Line",
      "img": "assets/img/h3.jpg",
      "author": "Christian Jennings",
      "description": "Through the eyes of thirteen men and women from seven different nations",
      "rate": 3.0
    }
  ];

  List genreArr = [
    {"name": "Biography", "img": "assets/img/b1.jpg"},
    {"name": "Business", "img": "assets/img/b2.jpg"},
    {"name": "Children", "img": "assets/img/b3.jpg"},
    {"name": "Cookery", "img": "assets/img/b4.jpg"},
    {"name": "Fiction", "img": "assets/img/b5.jpg"},
    {"name": "Graphic Novels", "img": "assets/img/b6.jpg"},
  ];
  List newReleaseArr = [
    {"name": "The future is now", "img": "assets/img/nr1.png"},
    {"name": "Who we are", "img": "assets/img/nr2.png"},
    {
      "name": "Fern Michaels",
      "img": "assets/img/nr3.png",
    },
    {
      "name": "Directional Living",
      "img": "assets/img/nr4.png",
    },
    {
      "name": "Gravity is bringing me down",
      "img": "assets/img/nr5.png",
    },
    {
      "name": "Time's Echo",
      "img": "assets/img/nr6.png",
    },
  ];
  List animArr = [
    {"name": "Love of Chocolate", "img": "assets/img/anm1.png"},
    {"name": "Sailor Moon", "img": "assets/img/anm2.png"},
    {"name": "Negima!", "img": "assets/img/anm3.png"},
    {"name": "Peach-Pit", "img": "assets/img/anm4.png"},
    {"name": "Attack on Titan", "img": "assets/img/anm5.png"},
    {"name": "A Silent Voice", "img": "assets/img/anm6.png"},
    {"name": "Devil Man", "img": "assets/img/anm7.png"},
    {"name": "Cardcaptor Sakura", "img": "assets/img/anm8.png"},
  ];
  List artArr = [
    {"name": "The Art of War", "img": "assets/img/nr7.png"},
    {"name": "The Art of Painting", "img": "assets/img/nr8.png"},
    {"name": "The Invisible", "img": "assets/img/nr9.png"},
    {"name": "Project Hail Mary", "img": "assets/img/nr10.png"},
    {"name": "Klara and the Sun", "img": "assets/img/nr11.png"},
    {"name": "The Midnight Library", "img": "assets/img/nr13.png"},
  ];

  List getBooksForSelectedTab() {
    if (txtSearch.text.isNotEmpty) {
      return searchBooks(txtSearch.text);
    } else {
      if (selectTag == 0) return genreArr;
      if (selectTag == 1) return newReleaseArr;
      if (selectTag == 2) return animArr;
      return artArr;
    }
  }

  List searchBooks(String query) {
    var allBooks = [...searchArr, ...genreArr, ...newReleaseArr, ...animArr, ...artArr];
    return allBooks.where((book) => book['name'].toString().toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: TColor.primary),
        ),
        title: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: TColor.textbox,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: txtSearch,
                  onChanged: (_) => setState(() {}),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchForceView(didSearch: (sText) {
                          txtSearch.text = sText;
                          setState(() {});
                        }),
                      ),
                    );
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                    prefixIcon: Icon(Icons.search, color: TColor.text),
                    suffixIcon: txtSearch.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              txtSearch.text = "";
                              setState(() {});
                            },
                            icon: Icon(Icons.cancel, color: TColor.text),
                          )
                        : IconButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchFilterView(
                                    didFilter: (_) => setState(() {}),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.tune, color: TColor.text),
                          ),
                    hintText: "Search Books, Authors, or ISBN",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                children: tagsArr.map((tagName) {
                  var index = tagsArr.indexOf(tagName);
                  return GestureDetector(
                    onTap: () => setState(() {
                      selectTag = index;
                      txtSearch.text = "";
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        tagName,
                        style: TextStyle(
                          color: selectTag == index ? TColor.text : TColor.subTitle,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.75,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: getBooksForSelectedTab().length,
              itemBuilder: (context, index) {
                var sObj = getBooksForSelectedTab()[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(bookData: sObj),
                      ),
                    );
                  },
                  child: SearchGridCell(sObj: sObj, index: index),
                );
              },
            ),
          ),
          if (txtSearch.text.isNotEmpty)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: sResultArr.length,
                itemBuilder: (context, index) {
                  var sObj = sResultArr[index];
                  return HistoryRow(sObj: sObj);
                },
              ),
            ),
        ],
      ),
    );
  }
}