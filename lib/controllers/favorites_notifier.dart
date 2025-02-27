import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesNotifier extends ChangeNotifier {
  // final _cartBox = Hive.box('cart_box');
  final _favBox = Hive.box('fav_box');

//------list of favs and ids-------//
  List<dynamic> _favorites = [];
  List<dynamic> _fav = [];

  List<dynamic> _ids = [];
  List<dynamic> get ids => _ids;

//------setter of ids-------//
  set ids(List<dynamic> newIds) {
    _ids = newIds;
    notifyListeners();
  }

//------getter and setter of favorites-------//
  List<dynamic> get favorites => _favorites;
  set favorites(List<dynamic> newFav) {
    _favorites = newFav;
    notifyListeners();
  }

  getFavorites() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item['id'],
      };
    }).toList();
    _favorites = favData.toList();
    _ids = _favorites.map((item) => item['id']).toList();
    // setState(() {});
  }

//------getter and setter of fav-------//
  List<dynamic> get fav => _fav;
  set fav(List<dynamic> newFav) {
    _favorites = newFav;
    notifyListeners();
  }

//------ getting all data as list------//
  getAllData() {
    // List<dynamic> fav = [];
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "price": item['price'],
        "imageUrl": item['imageUrl'],
      };
    }).toList();
    _fav = favData.reversed.toList();
  }

//------createing fav list function-------//
  Future<void> createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
    // getFavorites();
  }

  Future<void> deleteFav(int key) async {
    await _favBox.delete(key);
  }
}
