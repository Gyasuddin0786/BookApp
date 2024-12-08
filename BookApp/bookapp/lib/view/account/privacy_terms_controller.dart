import 'package:bookapp/common/color_extenstion.dart';
import 'package:bookapp/view/main_tab/main_tab_view.dart';
import 'package:flutter/material.dart';

class PrivacyTerms extends StatefulWidget {
  const PrivacyTerms({super.key});

  @override
  State<PrivacyTerms> createState() => _PrivacyTermsState();
}

class _PrivacyTermsState extends State<PrivacyTerms> {
  int page = 0;
  PageController? controller = PageController();
  List pageArr = [
    {
      "title": '“Privacy and Terms”',
      "sub_title": """This Privacy Policy describes Our policies and procedures on the collection, use 
      and disclosure of Your information when You use 
      the Service and tells You about Your privacy rights and how the law protects You.
      
      \n We use Your Personal data to provide and improve the Service. By using the Service, 
      You agree to the collection and use of information in accordance with this Privacy Policy. 
      This Privacy Policy has been created with the help of the Free Privacy Policy Generator.
      
      \n The words of which the initial letter is capitalized have meanings defined under the following conditions. 
      The following definitions shall have the same meaning regardless of whether they appear in singular or in plural. 
      Definitions For the purposes of this Privacy Policy:""",
    },
    {
      "title": '“Privacy and Terms”',
      "sub_title": """Personal Data is any information that relates to an identified or identifiable individual. 
      
      \n  Service Provider means any natural or legal person who processes the data on behalf of the Company. 
      It refers to third-party companies or individuals employed by the Company to facilitate the Service, 
      to provide the Service on behalf of the Company, 
      to perform services related to the Service or to assist the Company in analyzing how the Service is used.
      
      \n  Usage Data refers to data collected automatically, either generated by the use of the Service or from the
       Service infrastructure itself (for example, the duration of a page visit).
       
       \n While using Our Service, We may ask You to provide Us with certain personally 
       identifiable information that can be used to contact or identify You.
        Personally identifiable information may include, but is not limited to:""",

    },
    {
      "title": '“Privacy and Terms”',
      "sub_title": """Usage Data may include information such as Your Device's Internet Protocol address (e.g. IP address),
       browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, 
      unique device identifiers and other diagnostic data.   
      
      \n When You access the Service by or through a mobile device, 
      We may collect certain information automatically, including, but not limited to, the type of mobile device You use,
       Your mobile device unique ID, the IP address of Your mobile device,
       Your mobile operating system, the type of mobile Internet browser You use, 
      unique device identifiers and other diagnostic data.
      
      \n  You may also have the option of sharing additional information with the Company through 
      Your Third-Party Social Media Service's account. If You choose to provide such information and Personal Data, 
 """,
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
      appBar: AppBar(
        title: Text("Privacy and Terms"),
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
      ),
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
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: TColor.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      pObj["sub_title"].toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 15,
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
                                  builder: (context) => const MainTabView()));
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
                                    builder: (context) =>
                                        const MainTabView()));
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
      )),    );
  }
}