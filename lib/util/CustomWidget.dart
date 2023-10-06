import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWidget {
  Widget AlignCus(alignment, child) {
    return Align(
      alignment: alignment,
      child: child,
    );
  }

  Widget TextCus(data, color, double fontsize, fontfamily, fontWeight) {
    return Text(
      data,
      style: TextStyle(
          color: color,
          fontSize: fontsize,
          fontFamily: fontfamily,
          fontWeight: fontWeight),
    );
  }

  Widget textfieldcus(hintext, controller, obscureText) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintext,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color.fromARGB(255, 81, 80, 80))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
            borderSide: BorderSide(color: Color(0xffFF4500))),
      ),
    );
  }

  Widget Button1(onPressed, child) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffFF4500),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }

  Widget Button2(onPressed, child) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffFF4500),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }

  Widget sizboxCus(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget gridviewCus1(image, title, desc, price, length, onFunction) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 10, bottom: 10),
      child: GridView.builder(
        itemCount: length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 330,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      image[index],
                    ),
                  ),
                  sizboxCus(3),
                  TextCus(title[index], Colors.black, 14,
                      GoogleFonts.poppins().fontFamily, FontWeight.bold),
                  sizboxCus(3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextCus(desc[index], Colors.grey[800], 11,
                        GoogleFonts.poppins().fontFamily, FontWeight.normal),
                  ),
                  sizboxCus(3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          color: Color(0xffFF4500),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextCus(
                                    "Rs. ",
                                    Colors.white,
                                    14,
                                    GoogleFonts.poppins().fontFamily,
                                    FontWeight.bold),
                                TextCus(
                                    price[index],
                                    Colors.white,
                                    14,
                                    GoogleFonts.poppins().fontFamily,
                                    FontWeight.bold),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            onFunction(index);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10)),
                            ),
                            child: Icon(
                              CupertinoIcons.plus,
                              color: Colors.yellow,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget gridviewCus2(
      image, title, desc, price, length, indexDisplay, onFunction) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 10, bottom: 10),
      child: GridView.builder(
        itemCount: length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 330,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          final indexItem = indexDisplay[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      image[indexItem],
                    ),
                  ),
                  sizboxCus(3),
                  TextCus(title[indexItem], Colors.black, 14,
                      GoogleFonts.poppins().fontFamily, FontWeight.bold),
                  sizboxCus(3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextCus(desc[indexItem], Colors.grey[800], 11,
                        GoogleFonts.poppins().fontFamily, FontWeight.normal),
                  ),
                  sizboxCus(3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          color: Color(0xffFF4500),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextCus(
                                    "Rs. ",
                                    Colors.white,
                                    14,
                                    GoogleFonts.poppins().fontFamily,
                                    FontWeight.bold),
                                TextCus(
                                    price[indexItem].toString(),
                                    Colors.white,
                                    14,
                                    GoogleFonts.poppins().fontFamily,
                                    FontWeight.bold),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            onFunction(indexItem);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10)),
                            ),
                            child: Icon(
                              CupertinoIcons.plus,
                              color: Colors.yellow,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget listviewCus2(
      image, title, price, length, deleteFunction, minus, plus, count) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 10, bottom: 10),
      child: ListView.builder(
        itemCount: length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                deleteFunction(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color: Color.fromARGB(255, 223, 199, 149),
                        spreadRadius: 2)
                  ],
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(20)),
                ),
                child: ListTile(
                  leading: Image.asset(image[index]),
                  title: TextCus(title[index], Colors.black, 14,
                      GoogleFonts.poppins().fontFamily, FontWeight.bold),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextCus("Rs. ", Color(0xffFF4500), 13,
                          GoogleFonts.poppins().fontFamily, FontWeight.bold),
                      TextCus(price[index], Color(0xffFF4500), 13,
                          GoogleFonts.poppins().fontFamily, FontWeight.bold),
                    ],
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xffFF4500), width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                              onTap: () => minus(index),
                              child: Icon(CupertinoIcons.minus)),
                          SizedBox(
                            width: 8,
                          ),
                          TextCus(
                              "${count[index]}",
                              Color(0xffFF4500),
                              17,
                              GoogleFonts.poppins().fontFamily,
                              FontWeight.bold),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                              onTap: () => plus(index),
                              child: Icon(CupertinoIcons.plus)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
