import 'package:bookapp/common/color_extenstion.dart';
import 'package:bookapp/view/onboarding/welcome_view.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int page = 0;
  PageController? controller = PageController();
  List pageArr = [
    {
      "title": '“Reading Anytime\nAnywhere”',
      "sub_title":
          "Enjoy the freedom to dive into your favorite books whenever.",
      "img": "assets/img/on_1.jpg"
    },
    {
      "title": '“Discover  Next Favorite Book”',
      "sub_title": "Unlock a world of stories waiting to captivate you.",
      "img": "assets/img/on_3.jpg"
    },
    {
      "title": '“Books for Every Interest”',
      "sub_title":
          "Explore a diverse collection tailored to\nyour unique tastes.",
      "img": "assets/img/on_2.jpg"
    },
  ];

  @override
  void initState() {
    super.initState();

    controller?.addListener(() {
      page = controller?.page?.round() ?? 0;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pageArr.length,
            itemBuilder: (context, index) {
              var pObj = pageArr[index] as Map? ?? {};
              return Container(
                width: media.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                child: Column(
                  children: [
                    // Display the title
                    Text(
                      pObj["title"].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: TColor.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Display the subtitle
                    Text(
                      pObj["sub_title"].toString(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: TColor.primaryLight, fontSize: 14),
                    ),
                    SizedBox(
                      height: media.width * 0.25,
                    ),
                    // Display the image
                    Image.asset(
                      pObj["img"].toString(),
                      width: media.width * 0.8,
                      height: media.width * 0.6,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
              );
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomeView()));
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              color: TColor.primary,
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        )),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: pageArr.map((pObj) {
                        var index = pageArr.indexOf(pObj);

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: page == index
                                  ? TColor.primary
                                  : TColor.primaryLight,
                              borderRadius: BorderRadius.circular(7.5)),
                        );
                      }).toList(),
                    ),
                    TextButton(
                        onPressed: () {
                          if (page < 2) {
                            page = page + 1;
                            controller?.jumpToPage(page);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WelcomeView()));
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: TColor.primary,
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: media.width * 0.15,
              ),
            ],
          )
        ],
      )),
    );
  }
}
