

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class FavoritesNotifier extends ChangeNotifier {
  // List to store favorite items
  // final List<Map<String, dynamic>> _favorites = [];

  // Getter for the list of favorite items
  // List<Map<String, dynamic>> get favorites => _favorites;

  // Method to check if an item is already in favorites
  // bool isFavorite(String id) {
  //   print('Checking if $id is a favorite');
  //   return _favorites.any((item) => item['id'] == id);
  // }

  // // Method to add an item to the favorites
  // void addFavorite(Map<String, dynamic> item) {
  //   if (!isFavorite(item['id'])) {
  //     _favorites.add(item);
  //     notifyListeners();
  //   }
  // }

  // // Method to remove an item from the favorites
  // void removeFavorite(String id) {
  //   _favorites.removeWhere((item) => item['id'] == id);
  //   notifyListeners();
  // }

  // debugging code

  // void addFavorite(Map<String, dynamic> item) {
  //   if (!isFavorite(item['id'])) {
  //     _favorites.add(item);
  //     print('Item added to favorites: $item');
  //     notifyListeners();
  //   }
  // }

  // void removeFavorite(String id) {
  //   print('Before removing: $_favorites');
  //   _favorites.removeWhere((item) => item['id'] == id);
  //   print('After removing: $_favorites');
  //   notifyListeners();
  // }
}
