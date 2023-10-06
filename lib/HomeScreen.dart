import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzaapp/CartScreen.dart';
import 'package:pizzaapp/LoginScreen.dart';
import 'package:pizzaapp/util/CustomWidget.dart';
import 'package:pizzaapp/util/SharedPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  String username;
  HomeScreen(this.username, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomWidget cus = CustomWidget();
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreference().getImageList().then((image) {
      setState(() {
        allImages = image;
        cartvalue = allImages.length;
      });
    });
    SharedPreference().getTitleList().then((title) {
      setState(() {
        allTitle = title;
      });
    });
    SharedPreference().getDescList().then((desc) {
      setState(() {
        allDesc = desc;
      });
    });
    SharedPreference().getPriceList().then((price) {
      setState(() {
        allPrice = price;
      });
    });
  }

  int cartvalue = 0;
  Future<void> updateCart() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      final imgeList = prefs.getStringList('allimages') ?? [];
      cartvalue = imgeList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 248, 240, 224),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 248, 240, 224),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/user.png"),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  widget.username,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(
                            allImages.toList(),
                            allTitle.toList(),
                            allDesc.toList(),
                            allPrice.toList(),
                            updateCart),
                      ));
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: badges.Badge(
                      badgeContent: Text(
                        cartvalue == 0 ? "0" : cartvalue.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      child: Icon(
                        CupertinoIcons.shopping_cart,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                      "assets/logout.png",
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              cus.sizboxCus(10),
              CarouselSlider(
                items: [
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/im1.PNG',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/im2.PNG',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/im3.PNG',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/im4.PNG',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3), // Adjust as needed
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4, // Number of carousel items
                  (index) => Container(
                    margin: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                ),
              ),
              cus.sizboxCus(10),
              TabBar(
                  indicatorColor: Color(0xffea3b05),
                  unselectedLabelColor: Color.fromARGB(255, 233, 144, 116),
                  unselectedLabelStyle: TextStyle(fontSize: 14),
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  isScrollable: true,
                  labelColor: Color(0xffea3b05),
                  tabs: [
                    Text("TRENDING"),
                    Text("ALL PIZZA"),
                    Text("PASTA & BURGER"),
                  ]),
              Container(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(children: [
                  Trending(updateCart),
                  AllPizza(updateCart),
                  ColdDrink(updateCart),
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

List<dynamic> allImages = [];
List<dynamic> allTitle = [];
List<dynamic> allDesc = [];
List<dynamic> allPrice = [];
List<int> itemCounts = [];

class Trending extends StatefulWidget {
  Function updateCart;
  Trending(this.updateCart, {super.key});

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  CustomWidget cus = CustomWidget();

  Future<void> UpdateData() async {
    SharedPreference().getImageList().then((image) {
      setState(() {
        allImages = image;
      });
    });
    SharedPreference().getTitleList().then((title) {
      setState(() {
        allTitle = title;
      });
    });
    SharedPreference().getDescList().then((desc) {
      setState(() {
        allDesc = desc;
      });
    });
    SharedPreference().getPriceList().then((price) {
      setState(() {
        allPrice = price;
      });
    });
  }

  void addFunctionT(int indexT) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      allImages = prefs.getStringList('allimages') ?? [];
      allTitle = prefs.getStringList('alltitle') ?? [];
      allDesc = prefs.getStringList('alldesc') ?? [];
      allPrice = prefs.getStringList('allprice') ?? [];

      allImages.add(imagesT[indexT]);
      allTitle.add(titlesT[indexT]);
      allDesc.add(descT[indexT]);
      allPrice.add(priceT[indexT]);
      itemCounts.add(1);

      widget.updateCart();
      prefs.setStringList(
          'allimages', allImages.map((e) => e.toString()).toList());
      prefs.setStringList(
          'alltitle', allTitle.map((e) => e.toString()).toList());
      prefs.setStringList('alldesc', allDesc.map((e) => e.toString()).toList());
      prefs.setStringList(
          'allprice', allPrice.map((e) => e.toString()).toList());
      prefs.setStringList(
          'count', itemCounts.map((e) => e.toString()).toList());
    });
  }

  List<dynamic> imagesT = [
    'assets/p1.jpg',
    'assets/p2.jpg',
    'assets/p3.jpg',
    'assets/p4.jpg',
    'assets/p5.jpg'
  ];
  List<dynamic> titlesT = [
    'Arabian Night (New)',
    'Cream n Cheese (New)',
    'Creamy Tikka',
    'Bar B.Q Tikka',
    'Chicken Fajita'
  ];
  List<dynamic> descT = [
    'Spicy chicken, Tahini sauce & cheese',
    'Thousand sauce, malai meat, jalapenos',
    'Cream sauce, chicken tikka & onions.',
    'traditional chicken tikka, onions',
    'Chicken Fatija, onions, mushrooms'
  ];
  List<dynamic> priceT = ['499', '499', '499', '499', '499'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: cus.gridviewCus1(
          imagesT, titlesT, descT, priceT, titlesT.length, addFunctionT),
    );
  }
}

class AllPizza extends StatefulWidget {
  Function updateCart;
  AllPizza(this.updateCart, {super.key});

  @override
  State<AllPizza> createState() => _AllPizzaState();
}

class _AllPizzaState extends State<AllPizza> {
  CustomWidget cus = CustomWidget();

  Future<void> UpdateData() async {
    SharedPreference().getImageList().then((image) {
      setState(() {
        allImages = image;
      });
    });
    SharedPreference().getTitleList().then((title) {
      setState(() {
        allTitle = title;
      });
    });
    SharedPreference().getDescList().then((desc) {
      setState(() {
        allDesc = desc;
      });
    });
    SharedPreference().getPriceList().then((price) {
      setState(() {
        allPrice = price;
      });
    });
  }

  Future<void> addFunctionA(int indexA) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      allImages = prefs.getStringList('allimages') ?? [];
      allTitle = prefs.getStringList('alltitle') ?? [];
      allDesc = prefs.getStringList('alldesc') ?? [];
      allPrice = prefs.getStringList('allprice') ?? [];
      allImages.add(imagesA[indexA]);
      allTitle.add(titlesA[indexA]);
      allDesc.add(descA[indexA]);
      allPrice.add(priceA[indexA].toString());
      itemCounts.add(1);

      widget.updateCart();
      prefs.setStringList(
          'allimages', allImages.map((e) => e.toString()).toList());
      prefs.setStringList(
          'alltitle', allTitle.map((e) => e.toString()).toList());
      prefs.setStringList('alldesc', allDesc.map((e) => e.toString()).toList());
      prefs.setStringList(
          'allprice', allPrice.map((e) => e.toString()).toList());
      prefs.setStringList(
          'count', itemCounts.map((e) => e.toString()).toList());
    });
  }

  List<dynamic> imagesA = [
    'assets/p1.jpg',
    'assets/p2.jpg',
    'assets/p3.jpg',
    'assets/p4.jpg',
    'assets/p5.jpg',
    'assets/p6.jpg',
    'assets/p7.jpg',
    'assets/p8.jpg',
    'assets/p9.jpg',
    'assets/p10.jpg'
  ];
  List<dynamic> titlesA = [
    'Arabian Night (New)',
    'Cream n Cheese (New)',
    'Creamy Tikka',
    'Bar B.Q Tikka',
    'Chicken Fajita',
    'Pure Cheese',
    'Chicken Malai',
    'Bihari Boti',
    'Chicken Shawarma',
    'Chicken Supremo'
  ];
  List<dynamic> descA = [
    'Spicy chicken, Tahini sauce & cheese',
    'Thousand sauce, malai meat, jalapenos',
    'Cream sauce, chicken tikka & onions.',
    'traditional chicken tikka, onions',
    'Chicken Fatija, onions, mushrooms',
    '100% mozzarella cheese for cheese lovers',
    'Chicken malai boti, onions, mushrooms',
    'Blend of bihari chicken, onions',
    'Delicate marination of chicken shawarma',
    'Thousand island sauce, marinated chicken'
  ];
  List<dynamic> priceA = [299, 599, 599, 699, 699, 799, 799, 899, 999, 299];
  double minPrice = 200;
  double maxPrice = 1000;
  List<int> indexDisplay = List.generate(10, (index) => index);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: RangeSlider(
              values: RangeValues(minPrice, maxPrice),
              min: 0,
              max: 1000,
              activeColor: Color(0xffea3b05),
              inactiveColor: Colors.grey[800],
              divisions: 10,
              labels: RangeLabels(
                'Rs. ${minPrice}',
                'Rs. ${maxPrice}',
              ),
              onChanged: (value) {
                setState(() {
                  minPrice = value.start;
                  maxPrice = value.end;

                  indexDisplay = List.generate(10, (index) {
                    if (priceA[index] >= minPrice &&
                        priceA[index] <= maxPrice) {
                      return index;
                    } else {
                      return -1;
                    }
                  }).where((index) => index != -1).toList();
                });
              },
            ),
          ),
          Expanded(
            child: cus.gridviewCus2(imagesA, titlesA, descA, priceA,
                indexDisplay.length, indexDisplay, addFunctionA),
          ),
        ],
      ),
    );
  }
}

class ColdDrink extends StatefulWidget {
  Function updateCart;
  ColdDrink(this.updateCart, {super.key});

  @override
  State<ColdDrink> createState() => _ColdDrinkState();
}

class _ColdDrinkState extends State<ColdDrink> {
  CustomWidget cus = CustomWidget();

  Future<void> UpdateData() async {
    SharedPreference().getImageList().then((image) {
      setState(() {
        allImages = image;
      });
    });
    SharedPreference().getTitleList().then((title) {
      setState(() {
        allTitle = title;
      });
    });
    SharedPreference().getDescList().then((desc) {
      setState(() {
        allDesc = desc;
      });
    });
    SharedPreference().getPriceList().then((price) {
      setState(() {
        allPrice = price;
      });
    });
  }

  Future<void> addFunctionD(int indexD) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      allImages = prefs.getStringList('allimages') ?? [];
      allTitle = prefs.getStringList('alltitle') ?? [];
      allDesc = prefs.getStringList('alldesc') ?? [];
      allPrice = prefs.getStringList('allprice') ?? [];
      allImages.add(imagesD[indexD]);
      allTitle.add(titlesD[indexD]);
      allDesc.add(descD[indexD]);
      allPrice.add(priceD[indexD]);
      itemCounts.add(1);
      widget.updateCart();
      prefs.setStringList(
          'allimages', allImages.map((e) => e.toString()).toList());
      prefs.setStringList(
          'alltitle', allTitle.map((e) => e.toString()).toList());
      prefs.setStringList('alldesc', allDesc.map((e) => e.toString()).toList());
      prefs.setStringList(
          'allprice', allPrice.map((e) => e.toString()).toList());
      prefs.setStringList(
          'count', itemCounts.map((e) => e.toString()).toList());
    });
  }

  List<dynamic> imagesD = [
    'assets/d1.jpg',
    'assets/d1.jpg',
    'assets/d1.jpg',
    'assets/d2.jpg',
    'assets/d3.jpg'
  ];
  List<dynamic> titlesD = [
    'Pizzeria Pasta',
    'Chicken Tikka Pasta',
    'Creamy Pasta',
    'Burger Chicken Fillet',
    'Burger Chicken Chapli'
  ];
  List<dynamic> descD = [
    'delicious pasta with melting cheese',
    'delicious pasta with Chicken Tikka chunks',
    'chicken chunks in Afghan flavor',
    'Fine quality bun stuffed with Chicken Fillet',
    'Fine quality bun stuffed with Chicken Chapli'
  ];
  List<dynamic> priceD = ['449', '449', '449', '499', '499'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: cus.gridviewCus1(
          imagesD, titlesD, descD, priceD, imagesD.length, addFunctionD),
    );
  }
}
