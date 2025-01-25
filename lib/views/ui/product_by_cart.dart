import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop/controllers/product_notifier.dart';
import 'package:shop/views/shared/appstyle.dart';
import 'package:shop/views/shared/category_button.dart';
import 'package:shop/views/shared/custom_spacer.dart';
import 'package:shop/views/shared/latest_shoe.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
  }

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getFemale();
    productNotifier.getMale();
    productNotifier.getKids();

    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  height: screenSize.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/top_image.jpg"),
                          fit: BoxFit.fill)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close, color: Colors.white)),
                            GestureDetector(
                                onTap: () {
                                  // Navigator.pop(context);
                                  filter();
                                },
                                child: Icon(FontAwesomeIcons.sliders,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                      TabBar(
                          padding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle:
                              appStyle(20, Colors.white, FontWeight.bold),
                          unselectedLabelColor: Colors.grey.withOpacity(0.5),
                          tabs: const [
                            Tab(text: "Men Shoes"),
                            Tab(text: "Women Shoes"),
                            Tab(text: "Kids Shoes"),
                          ]),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.175,
                  left: 16,
                  right: 12,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: TabBarView(controller: _tabController, children: [
                    LatestShoes(male: productNotifier.male),
                    LatestShoes(male: productNotifier.female),
                    LatestShoes(male: productNotifier.kids),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    // ignore: no_leading_underscores_for_local_identifiers
    double _value = 100;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.82,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              // like divider
              Container(
                height: 5,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black38,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.72,
                child: Column(children: [
                  const CustomSpacer(),
                  Text(
                    "Filter",
                    style: appStyle(40, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  Text(
                    "Gender",
                    style: appStyle(24, Colors.black, FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoryButton(buttonColor: Colors.black, label: "Men"),
                      CategoryButton(buttonColor: Colors.grey, label: "Women"),
                      CategoryButton(buttonColor: Colors.grey, label: "Kids"),
                      CustomSpacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Category",
                    style: appStyle(24, Colors.black, FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoryButton(buttonColor: Colors.black, label: "Men"),
                      CategoryButton(buttonColor: Colors.grey, label: "Women"),
                      CategoryButton(buttonColor: Colors.grey, label: "Kids"),
                    ],
                  ),
                  const CustomSpacer(),
                  Text("Price",
                      style: appStyle(24, Colors.black, FontWeight.w600)),
                  const CustomSpacer(),
                  Slider(
                    value: _value,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    thumbColor: Colors.black,
                    max: 500,
                    label: _value.toString(),
                    divisions: 50,
                    secondaryTrackValue: 200,
                    onChanged: (double value) {},
                  ),
                  const CustomSpacer(),
                  Text("Brand",
                      style: appStyle(20, Colors.black, FontWeight.bold)),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRect(
                            child: Image.asset('assets/images/adidas.png')),
                        ClipRect(child: Image.asset('assets/images/gucci.png')),
                        ClipRect(child: Image.asset('assets/images/nike.png')),
                        ClipRect(
                            child: Image.asset('assets/images/jordan.png')),
                      ],
                    ),
                  )
                ]),
              ),
            ],
          )),
    );
  }
}
