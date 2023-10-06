import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizzaapp/payment/stripe_api.dart';
import 'package:pizzaapp/util/CustomWidget.dart';
import 'package:pizzaapp/util/SharedPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  List<dynamic> allImage = [], allTitle = [], allDesc = [], allPrice = [];
  final Function updateCart;
  CartScreen(this.allImage, this.allTitle, this.allDesc, this.allPrice,
      this.updateCart,
      {super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreference().getImageList().then((image) {
      setState(() {
        allImages1 = image;
      });
    });
    SharedPreference().getTitleList().then((title) {
      setState(() {
        allTitle1 = title;
      });
    });
    SharedPreference().getDescList().then((desc) {
      setState(() {
        allDesc1 = desc;
      });
    });
    SharedPreference().getPriceList().then((price) {
      setState(() {
        allPrice1 = price;
        subTotal();
        Total();
      });
    });
    SharedPreference().getCountList().then((count) {
      setState(() {
        itemCounts = count;
      });
    });
    print(widget.allImage);
    print(widget.allTitle);
    print(widget.allDesc);
    print(widget.allPrice);
    print("intialization");
  }

  List<dynamic> allImages1 = [];
  List<dynamic> allTitle1 = [];
  List<dynamic> allDesc1 = [];
  List<dynamic> allPrice1 = [];
  List<int> itemCounts = [];

  Future<void> minus(int index) async {
    final prefs = await SharedPreferences.getInstance();
    if (index >= 0 && index < itemCounts.length && itemCounts[index] > 1) {
      setState(() {
        itemCounts[index]--;
        subPrice -= double.tryParse(allPrice1[index]) ?? 0.0;
        Total();
        // Convert the list of integers to a list of strings
        List<String> countListAsString =
            itemCounts.map((count) => count.toString()).toList();

        prefs.setStringList('count', countListAsString);
      });
    }
  }

  Future<void> plus(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      itemCounts[index]++;
      subPrice += double.tryParse(allPrice1[index]) ?? 0.0;
      Total();
      // Convert the list of integers to a list of strings
      List<String> countListAsString =
          itemCounts.map((count) => count.toString()).toList();

      prefs.setStringList('count', countListAsString);
    });
  }

  double subPrice = 0.0;
  Future<void> subTotal() async {
    final prefs = await SharedPreferences.getInstance();
    final priceList = prefs.getStringList('allprice') ?? [];
    int index = 0;

    for (int i = 0; i < priceList.length; i++) {
      subPrice += double.tryParse(priceList[index]) ?? 0.0;
      index++;
    }
    Total();
    setState(() {});
  }

  void subTotalMinus(int index) {
    if (itemCounts[index] == 1) {
      subPrice -= double.tryParse(allPrice1[index]) ?? 0.0;
    } else {
      subPrice -=
          (double.tryParse(allPrice1[index]) ?? 0.0) * itemCounts[index];
    }

    Total();
    setState(() {});
  }

  double total = 0.0;
  double deliveryCharges = 150.0;
  double tax = 50.0;
  void Total() {
    setState(() {
      total = subPrice + deliveryCharges + tax;
      print(subPrice);
      print(deliveryCharges);
      print(tax);
      print(total);
    });
  }

  Future<void> deleteFunction(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      subTotalMinus(index);

      widget.allImage.removeAt(index);
      widget.allTitle.removeAt(index);
      widget.allDesc.removeAt(index);
      widget.allPrice.removeAt(index);
      allImages1.removeAt(index);
      allTitle1.removeAt(index);
      allDesc1.removeAt(index);
      allPrice1.removeAt(index);
      itemCounts.removeAt(index);
      print("deletion");
      print(widget.allImage);
      print(widget.allTitle);
      print(widget.allDesc);
      print(widget.allPrice);
      print(allImages1);
      print(allTitle1);
      print(allDesc1);
      print(allPrice1);

      widget.updateCart();

      prefs.setStringList(
          'allimages', widget.allImage.map((e) => e.toString()).toList());
      prefs.setStringList(
          'alltitle', widget.allTitle.map((e) => e.toString()).toList());
      prefs.setStringList(
          'alldesc', widget.allDesc.map((e) => e.toString()).toList());
      prefs.setStringList(
          'allprice', widget.allPrice.map((e) => e.toString()).toList());
      // Convert the list of integers to a list of strings
      List<String> countListAsString =
          itemCounts.map((count) => count.toString()).toList();

      prefs.setStringList('count', countListAsString);
      Total();
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomWidget cus = CustomWidget();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 248, 240, 224),
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 140,
            ),
            cus.TextCus("Cart", Colors.black, 21,
                GoogleFonts.poppins().fontFamily, FontWeight.bold),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 248, 240, 224),
      body: Stack(
        children: [
          cus.AlignCus(
            Alignment.topCenter,
            Container(
                height: 410,
                child: cus.listviewCus2(
                    allImages1,
                    allTitle1,
                    allPrice1,
                    allImages1.length,
                    deleteFunction,
                    minus,
                    plus,
                    itemCounts)),
          ),
          cus.AlignCus(
            Alignment.bottomCenter,
            Container(
              height: 380,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  const BoxShadow(
                    blurRadius: 5,
                    color: Color.fromARGB(255, 234, 206, 151),
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
                  top: 30,
                ),
                child: Column(
                  children: [
                    cus.AlignCus(
                      Alignment.topLeft,
                      cus.TextCus("Payment", Color(0xffea3b05), 29,
                          GoogleFonts.poppins().fontFamily, FontWeight.bold),
                    ),

                    cus.sizboxCus(20),
                    cus.AlignCus(
                        Alignment.topLeft,
                        Container(
                          height: 2,
                          color: Color(0xffea3b05),
                        )),

                    cus.sizboxCus(20),
                    //subtotal
                    cus.AlignCus(
                      Alignment.topLeft,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cus.TextCus(
                              "SubTotal :",
                              Colors.black,
                              20,
                              GoogleFonts.poppins().fontFamily,
                              FontWeight.bold),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              cus.TextCus(
                                  "Rs. ",
                                  Color(0xffea3b05),
                                  20,
                                  GoogleFonts.poppins().fontFamily,
                                  FontWeight.bold),
                              cus.TextCus(
                                  "${subPrice.toString()}",
                                  Color(0xffea3b05),
                                  20,
                                  GoogleFonts.poppins().fontFamily,
                                  FontWeight.bold),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //delivery charges
                    cus.sizboxCus(5),
                    cus.AlignCus(
                      Alignment.topLeft,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cus.TextCus(
                              "Delivery Charges :",
                              Colors.black,
                              20,
                              GoogleFonts.poppins().fontFamily,
                              FontWeight.bold),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              cus.TextCus(
                                  "Rs. ",
                                  Color(0xffea3b05),
                                  20,
                                  GoogleFonts.poppins().fontFamily,
                                  FontWeight.bold),
                              cus.TextCus(
                                  "150",
                                  Color(0xffea3b05),
                                  20,
                                  GoogleFonts.poppins().fontFamily,
                                  FontWeight.bold),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //tax
                    cus.sizboxCus(5),
                    cus.AlignCus(
                      Alignment.topLeft,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cus.TextCus(
                              "TAX :",
                              Colors.black,
                              20,
                              GoogleFonts.poppins().fontFamily,
                              FontWeight.bold),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              cus.TextCus(
                                  "Rs. ",
                                  Color(0xffea3b05),
                                  20,
                                  GoogleFonts.poppins().fontFamily,
                                  FontWeight.bold),
                              cus.TextCus(
                                  "50",
                                  Color(0xffea3b05),
                                  20,
                                  GoogleFonts.poppins().fontFamily,
                                  FontWeight.bold),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //total
                    cus.sizboxCus(20),
                    cus.AlignCus(
                        Alignment.topLeft,
                        Container(
                          height: 2,
                          color: Color(0xffea3b05),
                        )),

                    cus.sizboxCus(20),
                    cus.AlignCus(
                      Alignment.topLeft,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cus.TextCus(
                              "TOTAL :",
                              Colors.black,
                              23,
                              GoogleFonts.poppins().fontFamily,
                              FontWeight.bold),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              cus.TextCus(
                                  "Rs. ",
                                  Color(0xffea3b05),
                                  22,
                                  GoogleFonts.poppins().fontFamily,
                                  FontWeight.bold),
                              cus.TextCus(
                                  "${total.toString()}",
                                  Color(0xffea3b05),
                                  22,
                                  GoogleFonts.poppins().fontFamily,
                                  FontWeight.bold),
                            ],
                          ),
                        ],
                      ),
                    ),
                    cus.sizboxCus(20),
                    cus.Button2(
                      () async {
                        //checkout

                        if (total != 0.0) {
                          int p = total.toInt();
                          print("this is value $p");
                          bool paymentSuccessful = await StripeAPI.makePayment(
                              p.toString(),
                              "PKR",
                              context); // Replace "PKR" with the desired currency code

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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          child: Image.asset(
                                            "assets/verify.png",
                                          ),
                                        ),
                                        Text(
                                          "Thank you for \nOrdering!",
                                          style: TextStyle(
                                            color: Color(0xffFF4500),
                                            fontSize: 22,
                                            fontFamily: GoogleFonts.poppins()
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
                          Navigator.pop(context);
                          if (paymentSuccessful) {
                            final prefs = await SharedPreferences.getInstance();
                            setState(() {
                              allImages1.clear();
                              allTitle1.clear();
                              allDesc1.clear();
                              allPrice1.clear();
                              widget.allImage.clear();
                              widget.allDesc.clear();
                              widget.allTitle.clear();
                              widget.allPrice.clear();

                              prefs.setStringList(
                                  'allimages',
                                  widget.allImage
                                      .map((e) => e.toString())
                                      .toList());
                              prefs.setStringList(
                                  'alltitle',
                                  widget.allTitle
                                      .map((e) => e.toString())
                                      .toList());
                              prefs.setStringList(
                                  'alldesc',
                                  widget.allDesc
                                      .map((e) => e.toString())
                                      .toList());
                              prefs.setStringList(
                                  'allprice',
                                  widget.allPrice
                                      .map((e) => e.toString())
                                      .toList());
                              subTotal();
                              Total();
                            });
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                  "No Item Found",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 19),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"))
                                ],
                              );
                            },
                          );
                        }
                      },
                      cus.TextCus("Checkout", Colors.white, 22,
                          GoogleFonts.poppins().fontFamily, FontWeight.bold),
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
