import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/controllers/favorites_notifier.dart';
import 'package:shop/views/shared/appstyle.dart';
import 'package:shop/views/ui/favorites.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.price,
      required this.category,
      required this.name,
      required this.id,
      required this.image,
      required this.ratings,
      required this.reviews});

  final String price;
  final String category;
  final String name;
  final String id;
  final String image;
  final double reviews;
  final double ratings;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // final _favBox = Hive.box("fav_box");

  // Future<void> _createFav(Map<String, dynamic> addFav) async {
  //   await _favBox.add(addFav);
  //   getFavorites();
  // }

  // getFavorites(){
  //   final favData = _favBox.keys.map((key){

  //     final item = _favBox.get(key);
  //     return {
  //       "key" :key , 
  //       "id" : item['id'] , 
  //     };
  //   }
  //   ).toList();

  //   favor = favData.toList();
  //   ids = favor.map((item) => item['id']).toList();
  //   setState((){

  //   });

  // }


  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context , listen:true);
    favoritesNotifier.getFavorites();
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
                child: Column(children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.23,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () async {
                            if(favoritesNotifier.ids.contains(widget.id)){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Favorites()));
                            } else {
                              favoritesNotifier.createFav({
                                'id': widget.id,
                                'image': widget.image,
                                'name' : widget.name , 
                                'category' : widget.category,
                                'price' : widget.price,
                                'imageUrl' : widget.image
                              });
                            }
                             setState(() {});
                            },
                            child:favoritesNotifier.ids.contains(widget.id)? Icon(CommunityMaterialIcons.heart) : Icon(CommunityMaterialIcons.heart_outline)),
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
                                24, Colors.black, FontWeight.bold, 1.1),
                          ),
                          Text(widget.category,
                              style: appStyleWithHt(
                                  16, Colors.grey, FontWeight.bold, 1.5)),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.price.toString(),
                          style: appStyle(20, Colors.black, FontWeight.w600),
                        ),
                        Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Colors",
                                style:
                                    appStyle(15, Colors.grey, FontWeight.w600),
                              ),
                              SizedBox(width: 5),
                              ChoiceChip(
                                label: Text(""),
                                selected: selected,
                                visualDensity: VisualDensity.compact,
                                selectedColor: Colors.black,
                              )
                            ]),
                      ],
                    ),
                  ),
                  // RatingsRowWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            widget.ratings.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.reviews.toString(),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]))));
  }
}

// class RatingsRowWidget extends StatelessWidget {
//   const RatingsRowWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left:12.0),
//               child: Icon(
//                 Icons.star,
//                 color: Colors.amber,
//                 size: 18,
//               ),
//             ),
//             SizedBox(width: 4),
//             Text(
//                widget.ratings.toString(),
//               // "4.5",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//         Expanded(
//           child: Center(
//             child: Text(
//               widget.reviews.toString(),
//               // "123 reviews",
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
