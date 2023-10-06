import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizzaapp/LoginScreen.dart';
import 'package:pizzaapp/util/CustomWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  List<dynamic> email = [];
  List<dynamic> pass = [];
  List<dynamic> name = [];

  Future<void> SaveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('email', email.map((e) => e.toString()).toList());
    prefs.setStringList('pass', pass.map((e) => e.toString()).toList());
    prefs.setStringList('name', name.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    CustomWidget cus = CustomWidget();
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          cus.AlignCus(
            Alignment.topCenter,
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/Ivory & Green Minimalist Phone Mockup Mood Board Beauty Pinterest Pin.png"),
                      fit: BoxFit.fitWidth)),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 60, right: 60, bottom: 60),
                child: Image.asset(
                    "assets/Colorful Playful Yummy Pizza Mascot Free Logo.png"),
              ),
            ),
          ),
          cus.AlignCus(
            Alignment.bottomCenter,
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 535,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color.fromARGB(255, 224, 173, 71),
                        spreadRadius: 4,
                      )
                    ],
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(70.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: 30,
                    ),
                    child: Column(
                      children: [
                        cus.AlignCus(
                          Alignment.topLeft,
                          cus.TextCus(
                              "REGISTER",
                              Color(0xffFF4500),
                              35,
                              GoogleFonts.montserrat().fontFamily,
                              FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        cus.AlignCus(
                          Alignment.topLeft,
                          cus.TextCus(
                              "Email",
                              Colors.black,
                              20,
                              GoogleFonts.openSans().fontFamily,
                              FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        cus.textfieldcus(
                            "Enter your email", emailcontroller, false),
                        SizedBox(
                          height: 10,
                        ),
                        cus.AlignCus(
                          Alignment.topLeft,
                          cus.TextCus(
                              "Name",
                              Colors.black,
                              20,
                              GoogleFonts.openSans().fontFamily,
                              FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        cus.textfieldcus(
                            "Enter your name", namecontroller, false),
                        SizedBox(
                          height: 10,
                        ),
                        cus.AlignCus(
                          Alignment.topLeft,
                          cus.TextCus(
                              "Password",
                              Colors.black,
                              20,
                              GoogleFonts.openSans().fontFamily,
                              FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        cus.textfieldcus(
                            "Enter your password", passcontroller, true),
                        SizedBox(
                          height: 30,
                        ),
                        cus.Button1(
                          () {
                            //Signup button logic here
                            if (emailcontroller.text.isNotEmpty &&
                                passcontroller.text.isNotEmpty &&
                                namecontroller.text.isNotEmpty) {
                              var email1 = emailcontroller.text.toString();
                              var pass1 = passcontroller.text.toString();
                              var name1 = namecontroller.text.toString();
                              print(email1);
                              print(pass1);
                              print(name1);
                              setState(() {
                                email.add(email1);
                                pass.add(pass1);
                                name.add(name1);
                                SaveData();

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Color(0xffFFEABF),
                                      content: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/Ivory & Green Minimalist Phone Mockup Mood Board Beauty Pinterest Pin.png"),
                                                  fit: BoxFit.fill)),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50),
                                                child: Image.asset(
                                                  "assets/verify.png",
                                                ),
                                              ),
                                              Text(
                                                "Thank you for your\nregisteration!",
                                                style: TextStyle(
                                                  color: Color(0xffFF4500),
                                                  fontSize: 20,
                                                  fontFamily:
                                                      GoogleFonts.poppins()
                                                          .fontFamily,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                                emailcontroller.clear();
                                passcontroller.clear();
                                namecontroller.clear();
                                Timer(Duration(seconds: 3), () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ));
                                });
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Center(
                                      child: Text(
                                          'Please fill the empty fields.')),
                                ),
                              );
                            }
                          },
                          cus.TextCus(
                              "Signup",
                              Colors.white,
                              30,
                              GoogleFonts.openSans().fontFamily,
                              FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            cus.TextCus(
                                "Already have an account?",
                                Colors.grey,
                                16,
                                GoogleFonts.openSans().fontFamily,
                                FontWeight.bold),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ));
                              },
                              child: cus.TextCus(
                                  "Login here",
                                  Color(0xffFF4500),
                                  16,
                                  GoogleFonts.openSans().fontFamily,
                                  FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
