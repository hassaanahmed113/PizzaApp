import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pizzaapp/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/Ivory & Green Minimalist Phone Mockup Mood Board Beauty Pinterest Pin.png"),
                    fit: BoxFit.fitHeight)),
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
                "assets/Colorful Playful Yummy Pizza Mascot Free Logo.png"),
          ),
        ),
      ),
    );
  }
}
