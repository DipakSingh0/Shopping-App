import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shop/models/sneakers_model.dart';
import 'package:shop/services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;

  List<dynamic> _shoesSizes = [];
  List<String> _sizes = [];

  int get activePage => _activePage;
  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoesSizes => _shoesSizes;
  set shoesSizes(List<dynamic> newSizes) {
    _shoesSizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _shoesSizes.length; i++) {
      if (i == index) {
        _shoesSizes[i]['isSelected'] = !_shoesSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;
  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

// ------------for ProductCard  Page displaying sneakers------------------//

  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;

  void getMale() {
    male = Helper().getMaleSneakers();
  }

  void getFemale() {
    female = Helper().getFemaleSneakers();
  }

  void getKids() {
    kids = Helper().getKidsSneakers();
  }

// ------------for ProductPage displaying category items ------------------//
  late Future<Sneakers> sneaker;
  void getShoes(String category, String id) {
    if (category == "Men's Shoes") {
      sneaker = Helper().getMaleSneakersById(id);
    } else if (category == "Women's Running") {
      sneaker = Helper().getfemaleSneakersById(id);
    } else {
      sneaker = Helper().getKidsSneakersById(id);
    }
  }

// ------------for Product Page createCart------------------//
  final _cartBox = Hive.box('cart_box');

  Future<void> createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }
}
