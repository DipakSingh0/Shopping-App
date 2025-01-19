import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:shop/shared/appstyle.dart';

class ProductCart extends StatefulWidget {
  const ProductCart(
      {super.key,
      required this.price,
      required this.category,
      required this.name,
      required this.id,
      required this.image});

  final String price;
  final String category;
  final String name;
  final String id;
  final String image;

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    bool selected = true;
    return Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 20, 0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.23,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget
                                .image), // Assuming 'image' is a variable holding the image URL
                            fit: BoxFit.cover, // Adjust fit as needed
                          ),
                        ),
                      ),
                      Positioned(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: null,
                                child:
                                    Icon(CommunityMaterialIcons.heart_outline)),
                          ))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        children: [
                          Text(
                            widget.name,
                            style: appStyleWithHt(
                                36, Colors.black, FontWeight.bold, 1.1),
                          ),
                          Text(widget.category,
                              style: appStyleWithHt(
                                  18, Colors.grey, FontWeight.bold, 1.5)),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.price.toString(),
                          style: appStyle(30, Colors.black, FontWeight.w600),
                        ),
                        Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Colors",
                                style:
                                    appStyle(18, Colors.grey, FontWeight.w500),
                              ),
                              SizedBox(width: 5),

                              ChoiceChip(label: Text(""),
                               selected: selected , 
                               visualDensity: VisualDensity.compact,
                               selectedColor: Colors.black,
                               )
                            ])
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
