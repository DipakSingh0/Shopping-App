import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shop/controllers/favorites_notifier.dart';
import 'package:shop/controllers/product_notifier.dart';
import 'package:shop/models/constants.dart';
import 'package:shop/models/sneakers_model.dart';
import 'package:shop/services/helper.dart';
import 'package:shop/views/shared/appstyle.dart';
import 'package:shop/views/shared/checkout_buttton.dart';
import 'package:shop/views/ui/favorites.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');
  // final _favBox = Hive.box('fav_box');

  late Future<Sneakers> _sneaker;

  void getShoes() {
    if (widget.category == "Men's Shoes") {
      _sneaker = Helper().getMaleSneakersById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneaker = Helper().getfemaleSneakersById(widget.id);
    } else {
      _sneaker = Helper().getKidsSneakersById(widget.id);
    }
  }

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  final _favBox = Hive.box("fav_box");

  Future<void> _createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
    getFavorites();
  }

    Future<void> _deleteFav(String favId) async {
    final favItem = _favBox.values
        .firstWhere((item) => item['id'] == favId, orElse: () => null);
    if (favItem != null) {
      await _favBox.delete(favItem['key']);
      getFavorites();
    }
  }

  getFavorites() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);

      return {
        "key": key,
        "id": item['id'],
      };
    }).toList();

    favor = favData.toList();
    ids = favor.map((item) => item['id']).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: FutureBuilder<Sneakers>(
            future: _sneaker,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final sneaker = snapshot.data;

                return Consumer<ProductNotifier>(
                    builder: (context, productNotifier, child) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        leadingWidth: 0,
                        title: Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  productNotifier.shoesSizes.clear();
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: null,
                                child: const Icon(
                                  Icons.more_horiz,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pinned: true,
                        snap: false,
                        floating: true,
                        backgroundColor: Colors.transparent,
                        expandedHeight: screenSize.height,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(children: [
                            SizedBox(
                              height: screenSize.height * 0.5,
                              width: screenSize.width,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneaker!.imageUrl.length,
                                controller: pageController,
                                onPageChanged: (page) {
                                  productNotifier.activePage = page;
                                },
                                itemBuilder: (context, int index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height: screenSize.height * 0.39,
                                        width: screenSize.width * 0.39,
                                        color: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                          imageUrl: sneaker.imageUrl[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                          top: screenSize.height * 0.10,
                                          right: 20,
                                          child: Consumer<FavoritesNotifier>(
                                            builder: (context,
                                                favoritesNotifier, child) {
                                              return GestureDetector(
                                                onTap: () {
                                                  if (ids.contains(sneaker.id)) {


                                                    // Handle removal from favorites
                                                    _deleteFav(sneaker.id);


                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const Favorites()));
                                                  } else {
                                                    // Handle adding to favorites
                                                    _createFav({
                                                      "id": sneaker.id,
                                                      "name": sneaker.name,
                                                      "category":
                                                          sneaker.category,
                                                      "price": sneaker.price,
                                                      "imageUrl":
                                                          sneaker.imageUrl[0],
                                                    });
                                                  }
                                                },
                                                child: ids.contains(sneaker.id)
                                                    ? const Icon(Icons.favorite,
                                                        color: Colors.red)
                                                    : const Icon(
                                                        Icons.favorite_outline,
                                                        color: Colors.red,
                                                      ),
                                              );
                                            },
                                          )),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height: screenSize.height * 0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                            sneaker.imageUrl.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: CircleAvatar(
                                                radius: 5,
                                                backgroundColor: productNotifier
                                                            .activePage !=
                                                        index
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height: screenSize.height * 0.645,
                                  width: screenSize.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            sneaker.name,
                                            style: appStyle(40, Colors.black,
                                                FontWeight.bold),
                                          ),
                                        ),
                                        // --------------------- Ratings ROW ----------------------------//
                                        Row(
                                          children: [
                                            SizedBox(height: 10),
                                            Text(
                                              sneaker.category,
                                              style: appStyle(20, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            RatingBar.builder(
                                              initialRating: 4,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 22,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 1),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                size: 18,
                                                color: Colors.black,
                                              ),
                                              onRatingUpdate: (rating) {},
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),

                                        // --------------------- PRICE ROW ----------------------------//
                                        PriceRow(sneaker: sneaker),

                                        // --------------------- Select Size ROW ----------------------------//

                                        SelectSizeRow(),

                                        // ---------------------  Sizes List ROW ----------------------------//

                                        SizedBox(
                                          height: 40,
                                          width: screenSize.width,
                                          child: ListView.builder(
                                            itemCount: productNotifier
                                                .shoesSizes.length,
                                            scrollDirection: Axis.horizontal,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index) {
                                              final sizes = productNotifier
                                                  .shoesSizes[index];
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: ChoiceChip(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                    side: const BorderSide(
                                                      color: Colors.black,
                                                      width: 1,
                                                      style: BorderStyle.solid,
                                                    ),
                                                  ),
                                                  disabledColor: Colors.white,
                                                  label: Text(
                                                    sizes['size'],
                                                    style: appStyle(
                                                        18,
                                                        sizes['isSelected']
                                                            ? Colors.white
                                                            : Colors.black,
                                                        FontWeight.w500),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  selectedColor: Colors.black,
                                                  selected: sizes['isSelected'],
                                                  onSelected: (newState) {
                                                    productNotifier
                                                        .toggleCheck(index);
                                                    if (productNotifier.sizes
                                                        .contains(
                                                            sizes['size'])) {
                                                      productNotifier.sizes
                                                          .remove(
                                                              sizes['size']);
                                                    } else {
                                                      productNotifier.sizes
                                                          .add(sizes['size']);
                                                    }
                                                    // print(productNotifier.sizes);
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 10,
                                        // ), // SizedBox

                                        // const Divider(
                                        //   indent: 10,
                                        //   endIndent: 10,
                                        //   color: Colors.black,
                                        // ),

                                        //-----------------------------------Details --------------------------------//
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Text(
                                            sneaker.title,
                                            style: appStyle(26, Colors.black,
                                                FontWeight.w700),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          sneaker.description,
                                          style: appStyle(14, Colors.black,
                                              FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: CheckoutButtonWidget(
                                              onTap: () async {
                                                _createCart({
                                                  "id": sneaker.id,
                                                  "name": sneaker.name,
                                                  "category": sneaker.category,
                                                  "sizes":
                                                      productNotifier.sizes,
                                                  "imageUrl":
                                                      sneaker.imageUrl[0],
                                                  "price": sneaker.price,
                                                  "qty": 1
                                                });
                                                productNotifier.sizes.clear();
                                                Navigator.pop(context);
                                              },
                                              label: 'Add to Cart',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ],
                  );
                });
              }
            }));
  }
}

class SelectSizeRow extends StatelessWidget {
  const SelectSizeRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Select Sizes",
          style: appStyle(20, Colors.black, FontWeight.w600),
        ),
        const SizedBox(width: 30),
        Text(
          "View size guide",
          style: appStyle(20, Colors.grey, FontWeight.w600),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

class PriceRow extends StatelessWidget {
  const PriceRow({
    super.key,
    required this.sneaker,
  });

  final Sneakers? sneaker;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Rs ${sneaker?.price}",
          style: appStyle(26, Colors.black, FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Color :",
                style: appStyle(18, Colors.black, FontWeight.w500),
              ), // Text
              const SizedBox(width: 8),
              const CircleAvatar(
                radius: 7,
                backgroundColor: Colors.black,
              ),
              const SizedBox(width: 5),

              const CircleAvatar(
                radius: 7,
                backgroundColor: Colors.black,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
