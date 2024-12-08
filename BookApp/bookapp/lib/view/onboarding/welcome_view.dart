import 'package:bookapp/view/login/sign_in_view.dart';
import 'package:bookapp/view/login/sign_up_view.dart';
import 'package:flutter/material.dart';

import '../../common/color_extenstion.dart';
import '../../common_widget/round_button.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        SafeArea(
            child: Container(
              color: Colors.white,
          width: media.width,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '“Books for Every Taste”',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: TColor.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20,),
              Image.asset(
                'assets/img/test.jpg', // Replace with your image
                height: media.width * 0.8,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: media.width * 0.2,
              ),
              RoundButton(
                title: "Sign In",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInView()));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              RoundButton(
                title: "Sign Up",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpView()));
                },
              ),
            ],
          ),
        ))
      ]),
    );
  }
}
