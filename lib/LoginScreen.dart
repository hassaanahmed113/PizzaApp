import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizzaapp/HomeScreen.dart';
import 'package:pizzaapp/RegisterScreen.dart';
import 'package:pizzaapp/util/CustomWidget.dart';
import 'package:pizzaapp/util/SharedPreference.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passcontroller = TextEditingController();

  SharedPreference shp = SharedPreference();

  List<dynamic> email1 = [];
  List<dynamic> pass1 = [];
  List<dynamic> name1 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shp.getEmailList().then((email) {
      setState(() {
        email1 = email;
      });
    });
    shp.getNamelList().then((name) {
      setState(() {
        name1 = name;
      });
    });
    shp.getPassList().then((pass) {
      setState(() {
        pass1 = pass;
      });
    });
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
                padding: const EdgeInsets.only(left: 60, right: 60, bottom: 50),
                child: Image.asset(
                    "assets/Colorful Playful Yummy Pizza Mascot Free Logo.png"),
              ),
            ),
          ),
          cus.AlignCus(
            Alignment.bottomCenter,
            Container(
              height: 500,
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(70.0)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 40,
                  right: 40,
                  top: 40,
                ),
                child: Column(
                  children: [
                    cus.AlignCus(
                      Alignment.topLeft,
                      cus.TextCus("WELCOME", Color(0xffFF4500), 35,
                          GoogleFonts.montserrat().fontFamily, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    cus.AlignCus(
                      Alignment.topLeft,
                      cus.TextCus("Email", Colors.black, 20,
                          GoogleFonts.openSans().fontFamily, FontWeight.bold),
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
                      cus.TextCus("Password", Colors.black, 20,
                          GoogleFonts.openSans().fontFamily, FontWeight.bold),
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
                        //login button logic here
                        if (emailcontroller.text.isNotEmpty &&
                            passcontroller.text.isNotEmpty) {
                          var email2 = emailcontroller.text.toString();
                          var pass2 = passcontroller.text.toString();
                          int index = email1.indexOf(email2);
                          var name = name1[index];
                          if (email1.contains(email2) &&
                              pass1.contains(pass2)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(name),
                                ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Center(child: Text('No User found.')),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Center(
                                  child: Text('Please fill the empty fields.')),
                            ),
                          );
                        }
                      },
                      cus.TextCus("Login", Colors.white, 30,
                          GoogleFonts.openSans().fontFamily, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cus.TextCus("Don't have an account?", Colors.grey, 16,
                            GoogleFonts.openSans().fontFamily, FontWeight.bold),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ));
                          },
                          child: cus.TextCus(
                              "Register here",
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
        ],
      ),
    ));
  }
}
