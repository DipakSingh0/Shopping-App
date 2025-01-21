// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shop/models/sneakers_model.dart';
import 'package:shop/ui/product_by_cart.dart';
import 'appstyle.dart';
import 'new_shoes.dart';
import 'product_cart.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.ScreenSize,
    required Future<List<Sneakers>> male,
    required this.tabIndex,
  }) : _male = male;

  final Size ScreenSize;
  final Future<List<Sneakers>> _male;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --------------1st listview horizontal----------------//
        Container(
          height: ScreenSize.height * 0.42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final male = snapshot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final shoe = snapshot.data![index];
                        return ProductCart(
                          price: "Rs.${shoe.price}",
                          category: shoe.category,
                          name: shoe.name,
                          id: shoe.id,
                          image: shoe.imageUrl[0],
                          ratings: shoe.ratings ?? 0.0,
                          reviews: shoe.reviews ?? 0,
                        );
                      });
                }
              }),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Shoes",
                    style: appStyle(24, Colors.black, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductByCart(
                                    tabIndex: tabIndex,
                                  )));
                    },
                    child: Row(
                      children: [
                        Text(
                          "View All",
                          style: appStyle(20, Colors.black, FontWeight.w500),
                        ),
                        //  Icon(AntDesign.caretright , size: 20),
                        Icon(Icons.arrow_forward_ios, size: 20)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: ScreenSize.height * 0.14,
          // color: Colors.amber,
          // --------------2nd listview horizontal----------------//

          child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final male = snapshot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final shoe = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NewShoes(
                            ScreenSize: ScreenSize,
                            imageUrl: shoe.imageUrl[0],
                          ),
                        );
                      });
                }
              }),
        ),
      ],
    );
  }
}
