import 'dart:async';
import 'package:bookapp/view/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnboardingView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '“Welcome to Book Store”',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color.fromARGB(255, 44, 206, 190),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Life is nothing without books',
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 20),
            Image(
              image: AssetImage('assets/img/bookstore.png'),
              height: 350,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


