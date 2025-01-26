// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop/controllers/favorites_notifier.dart';
// import 'package:shop/views/shared/appstyle.dart';
// import 'package:shop/views/ui/main_screen.dart';

import 'package:shop/views/shared/export.dart';
import 'package:shop/views/ui/main_screen.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => FavoritesState();
}

class FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(
      context,
    );
    favoritesNotifier.getAllData();

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: Center(
          child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
            height: screenSize.height,
            width: screenSize.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/top_image.jpg"),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "My Favorites",
                style: appStyle(40, Colors.white, FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: ListView.builder(
              itemCount: favoritesNotifier.fav.length,
              itemBuilder: (BuildContext context, int index) {
                final shoe = favoritesNotifier.fav[index];

                return Padding(
                  padding: EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      height: screenSize.height * 0.18,
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            spreadRadius: 5,
                            blurRadius: 0.3,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: shoe['imageUrl'],
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12, left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      shoe['name'],
                                      style: appStyle(
                                          16, Colors.black, FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      shoe['category'],
                                      style: appStyle(
                                          16, Colors.black, FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${shoe['price']}",
                                      style: appStyle(
                                          18, Colors.black, FontWeight.w600),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: GestureDetector(
                                onTap: () {
                                  favoritesNotifier.deleteFav(shoe['key']);
                                  //------this PRINT is for debugging purpose to know if it delets reqd shoe -------//
                                  // print("delete id $shoe");
                                  favoritesNotifier.ids.removeWhere(
                                      (element) => element == shoe['id']);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainScreen()));
                                },
                                child: Icon(
                                  Icons.favorite,
                                  size: 35,
                                  color: Colors.red,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )),
    ));
  }
}
