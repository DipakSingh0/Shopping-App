import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shop/controllers/product_notifier.dart';
import 'package:shop/models/sneakers_model.dart';
import 'package:shop/services/helper.dart';
import 'package:shop/shared/appstyle.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

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
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.grey,
                                        ),
                                      ),
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
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              sneaker.name,
                                              style: appStyle(40, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                sneaker.category,
                                                style: appStyle(
                                                    20,
                                                    Colors.black,
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
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${sneaker.price}",
                                                style: appStyle(
                                                    26,
                                                    Colors.black,
                                                    FontWeight.w600),
                                              ), // Text

                                              Row(
                                                children: [
                                                  Text(
                                                    "Colors",
                                                    style: appStyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w500),
                                                  ), // Text
                                                  const SizedBox(width: 5),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Select Sizes",
                                                        style: appStyle(
                                                            20,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      ),
                                                      const SizedBox(width: 20),
                                                      Text(
                                                        "View size guide",
                                                        style: appStyle(
                                                            20,
                                                            Colors.grey,
                                                            FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    height: 40,
                                                    child: ListView.builder(
                                                      itemCount: 3,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      padding: EdgeInsets.zero,
                                                      itemBuilder:
                                                          (context, index) {
                                                        // return ChoiceChip(
                                                        //   label: label,
                                                        //   selected: selected,
                                                        // );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ]),
                                  )),
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
