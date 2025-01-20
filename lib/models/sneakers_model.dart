import 'dart:convert';

List<Sneakers> sneakersFromJson(String str) =>
    List<Sneakers>.from(json.decode(str).map((x) => Sneakers.fromJson(x)));

class Sneakers {
  final String id;
  final String name;
  final String category;
  final List<String> imageUrl;
  final String oldPrice;
  final List<dynamic> sizes;
  final String price;
  final String description;
  final String title;
  final double ? ratings;
  final double ? reviews;


  Sneakers({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.sizes,
    required this.price,
    required this.description,
    required this.title,
     this.ratings , 
     this.reviews ,
  });

  // Factory method to create a Sneakers instance from JSON
  factory Sneakers.fromJson(Map<String, dynamic> json) => Sneakers(
        id: json['id'] ?? '', 
        name: json['name'] ?? '',  
        category: json['category'] ?? '', 
        imageUrl: List<String>.from(json['imageUrl'] ?? []), 
        oldPrice: json['oldPrice'] ?? '',  
        sizes: List<dynamic>.from(json['sizes']?.map((x) => x) ?? []), 
        price: json['price'] ?? '',  
        description: json['description'] ?? '',  
        title: json['title'] ?? '',
        ratings: json['ratings']?.toDouble() ?? '' , 
        // reviews: json['reviews']?.toInt() ?? '' ,
        reviews: json['reviews']?.toInt() ?? '',
      );
}
