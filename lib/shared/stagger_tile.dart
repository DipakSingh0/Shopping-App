import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'appstyle.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.price});

  final String imageUrl;
  final String name;
  final String price;

  @override
  State<StaggerTile> createState() => _StaggerTileState();

  static extent(int i, double d) {}
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Use 'const' with the constructor to improve
        borderRadius: BorderRadius.all(Radius.circular(16)), // Use 'const' with
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.fill,
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 12), // Use 'const' with the constructor to improve
            height: 75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: appStyleWithHt(20, Colors.black, FontWeight.w700, 1),
                ),
                Text(
                  widget.price,
                  style: appStyleWithHt(20, Colors.black, FontWeight.w500, 1),
                ),
              ],
            ), // Column
          ) // Container
        ],
      ),
    ); // Container
  }
}
