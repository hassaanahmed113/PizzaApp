import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  Future<List<dynamic>> getEmailList() async {
    final prefs = await SharedPreferences.getInstance();
    final emailList = prefs.getStringList('email') ?? [];
    return emailList;
  }

  Future<List<dynamic>> getNamelList() async {
    final prefs = await SharedPreferences.getInstance();
    final nameList = prefs.getStringList('name') ?? [];
    return nameList;
  }

  Future<List<dynamic>> getPassList() async {
    final prefs = await SharedPreferences.getInstance();
    final passList = prefs.getStringList('pass') ?? [];
    return passList;
  }

  Future<List<dynamic>> getImageList() async {
    final prefs = await SharedPreferences.getInstance();
    final getImageList = prefs.getStringList('allimages') ?? [];
    return getImageList;
  }

  Future<List<dynamic>> getTitleList() async {
    final prefs = await SharedPreferences.getInstance();
    final getTitleList = prefs.getStringList('alltitle') ?? [];
    return getTitleList;
  }

  Future<List<dynamic>> getDescList() async {
    final prefs = await SharedPreferences.getInstance();
    final getDescList = prefs.getStringList('alldesc') ?? [];
    return getDescList;
  }

  Future<List<dynamic>> getPriceList() async {
    final prefs = await SharedPreferences.getInstance();
    final getPriceList = prefs.getStringList('allprice') ?? [];
    return getPriceList;
  }

  Future<List<int>> getCountList() async {
    final prefs = await SharedPreferences.getInstance();
    final getCountList = prefs.getStringList('count') ?? [];

    // Convert the list of strings to a list of integers
    List<int> countList =
        getCountList.map((count) => int.tryParse(count) ?? 0).toList();

    return countList;
  }

  Future<double> getSubprice() async {
    final prefs = await SharedPreferences.getInstance();
    double subPrice = prefs.getDouble('subprice') ?? 0.0;
    return subPrice;
  }
}
