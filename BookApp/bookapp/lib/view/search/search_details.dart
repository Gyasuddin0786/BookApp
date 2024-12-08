import 'package:bookapp/common/color_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookDetailScreen extends StatefulWidget {
  final Map bookData;

  const BookDetailScreen({Key? key, required this.bookData}) : super(key: key);

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool isDark = false;
  double fontSize = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              floating: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                widget.bookData["name"].toString(),
                style: TextStyle(
                    color: isDark ? Colors.white : TColor.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: TColor.primary,
                ),
              ),
              actions: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Switch(
                      activeColor: TColor.primary,
                      value: isDark,
                      onChanged: (value) {
                        setState(() {
                          isDark = value;
                        });
                      },
                    ),
                    Text(
                      "Dark",
                      style: TextStyle(
                          color: isDark ? Colors.white : TColor.text,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          isScrollControlled: true,
                          builder: (context) {
                            var orientation =
                                MediaQuery.of(context).orientation;
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal:
                                      orientation == Orientation.portrait
                                          ? 25
                                          : 60),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: TColor.text,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.text_decrease,
                                        color: TColor.text,
                                        size: 20,
                                      ),
                                      Expanded(child: StatefulBuilder(
                                        builder: (context, setState) {
                                          return Slider(
                                            activeColor: TColor.text,
                                            inactiveColor: TColor.subTitle,
                                            thumbColor: Colors.white,
                                            min: 8.0,
                                            max: 70.0,
                                            value: fontSize,
                                            onChanged: (value) {
                                              setState(() {
                                                fontSize = value;
                                              });
                                              updateUi();
                                            },
                                          );
                                        },
                                      )),
                                      Icon(
                                        Icons.text_increase,
                                        color: TColor.text,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: TColor.textbox,
                                        border: Border.all(
                                            color: Colors.black26, width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      hint: const Text("Font"),
                                      underline: Container(),
                                      items: ["Font1", "Font2"].map((name) {
                                        return DropdownMenuItem(
                                          value: name,
                                          child: Text(name),
                                        );
                                      }).toList(),
                                      onChanged: (selectVal) {},
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.light_mode,
                                        color: TColor.text,
                                        size: 20,
                                      ),
                                      Expanded(child: StatefulBuilder(
                                        builder: (context, setState) {
                                          return Slider(
                                            activeColor: TColor.text,
                                            inactiveColor: TColor.subTitle,
                                            thumbColor: Colors.white,
                                            min: 8.0,
                                            max: 70.0,
                                            value: fontSize,
                                            onChanged: (value) {
                                              setState(() {
                                                fontSize = value;
                                              });
                                            },
                                          );
                                        },
                                      )),
                                      Icon(
                                        Icons.light_mode,
                                        color: TColor.text,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          SystemChrome
                                              .setPreferredOrientations([
                                            DeviceOrientation.portraitDown,
                                            DeviceOrientation.portraitUp
                                          ]);
                                        },
                                        padding: EdgeInsets.zero,
                                        icon: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: orientation ==
                                                      Orientation.portrait
                                                  ? TColor.subTitle
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Icon(
                                            Icons.stay_current_portrait,
                                            color: TColor.text,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          SystemChrome
                                              .setPreferredOrientations([
                                            DeviceOrientation.landscapeLeft,
                                            DeviceOrientation.landscapeRight
                                          ]);
                                        },
                                        padding: EdgeInsets.zero,
                                        icon: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: orientation ==
                                                      Orientation.landscape
                                                  ? TColor.subTitle
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Icon(
                                            Icons.stay_current_landscape,
                                            color: TColor.text,
                                            size: 30,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.settings,
                        color: TColor.primary,
                      ),
                    ),
                  ],
                )
              ],
            )
          ];
        },
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.bookData['img'], height: 200,width: 200,alignment: Alignment.center,),
            const SizedBox(height: 6),
            Text(
              widget.bookData['name'] ?? '',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.bookData['description'] ??
                  'Books are an essential part of our lives, offering both knowledge and inspiration. They open doors to new ideas and perspectives, helping us understand different cultures, histories, and philosophies. Reading books fosters creativity and expands our imagination, allowing us to think beyond our everyday experiences. They provide a sense of peace and relaxation, often serving as a refuge from the chaos of life. Good books motivate us to strive for success and overcome challenges through the wisdom they impart.',
             style: TextStyle(
                color: isDark ? Colors.white : TColor.text, fontSize: fontSize),
            ),
          ],
        ),
      ),
      ),
    );
    
  }
  void updateUi() {
    setState(() {});
  }
}