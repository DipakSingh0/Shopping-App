import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/sneakers_model.dart';
import 'package:shop/services/helper.dart';
import 'package:shop/shared/appstyle.dart';
import 'package:shop/shared/product_cart.dart';
// import 'package:ant_design_icons_flutter/ant_design_icons_flutter.dart';
// import 'package:shop/shared/appstyle.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

      late Future<List<Sneakers>> _male;
      late Future<List<Sneakers>> _female;
      late Future<List<Sneakers>> _kids;


      void getMale() {
        _male = Helper().getMaleSneakers();
      }
      void getFemale() {
        _male = Helper().getMaleSneakers();
      }
      void getKids() {
        _male = Helper().getMaleSneakers();
      }

      @override
      void initState() {
        super.initState();
        getMale();
        getFemale();
        getKids();
        }

      

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    var ScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Colors.grey.shade400,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(16, 25, 0, 0),
                height: ScreenSize.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/top_image.jpg"),
                        fit: BoxFit.fill)),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, bottom: 12),
                  width: ScreenSize.width,
                  // height: MediaQuery.of(context).size.height,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Athletics Shoes",
                          style: appStyleWithHt(
                              35, Colors.white, FontWeight.bold, 1.5)),
                      Text("Collection",
                          style: appStyleWithHt(
                              35, Colors.white, FontWeight.bold, 1.5)),
                      TabBar(
                        padding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle:
                              appStyle(20, Colors.white, FontWeight.bold),
                          unselectedLabelColor: Colors.grey.withOpacity(0.4),
                          tabs: const [
                            Tab(text: "Men Shoes"),
                            Tab(text: "Women Shoes"),
                            Tab(text: "Kids Shoes"),
                          ]),
                    ],
                  ),
                )),
            // ... other children

            Padding(
              padding: EdgeInsets.only(top: ScreenSize.height * 0.240),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(controller: _tabController, children: [
                  Column(
                    children: [
                      // --------------1st listview horizontal----------------//

                      Container(
                        height: ScreenSize.height * 0.405,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // decoration: BoxDecoration(
                        // color: Colors.white,
                        // borderRadius:
                        // BorderRadius.all(Radius.circular(16))),
                        child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return const ProductCart(
                                price: "Rs.2000", 
                                category: "Men Shoes", 
                                name: "Air", 
                                id: "1", 
                                image: 'https://media.istockphoto.com/id/1326433058/photo/pair-of-brown-leather-shoes-isometric-view.jpg?s=612x612&w=is&k=20&c=Vg5tVZO8Y3jGuBqPaHpx5sj0_Iz-iVuLqusFd74Psu0=' );
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //     height: ScreenSize.height,
                              //     width: ScreenSize.width * 0.6,
                              //   ),
                              // );
                            }),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 12, 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Latest Shoes",
                                  style: appStyle(
                                      24, Colors.black, FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "View All",
                                      style: appStyle(
                                          22, Colors.black, FontWeight.w500),
                                    ),
                                    //  Icon(AntDesign.caretright , size: 20),
                                    Icon(Icons.arrow_forward_ios, size: 20)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.height * 0.15,
                        // color: Colors.amber,
                        // --------------2nd listview horizontal----------------//

                        child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          spreadRadius: 1,
                                          blurRadius: 0.8,
                                          offset: Offset(0, 1),
                                        )
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  height: ScreenSize.height * 0.12,
                                  width: ScreenSize.width * 0.28,
                                  child:
                                      // Image(image: AssetImage('lib/assets/images/shoe1.png'))
                                      // Image.network('https://picsum.photos/200/300', fit: BoxFit.fill),
                                      ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://media.istockphoto.com/id/679539162/photo/indian-made-mens-shoes.jpg?s=612x612&w=is&k=20&c=1pnIbNcLqcYNowO-0h6fClFv7q9jykOrLusf1qH3byU=", // Replace with the actual image URL
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: ScreenSize.height * 0.405,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.405,
                        color: Colors.blue,
                      ),
                    ],
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
