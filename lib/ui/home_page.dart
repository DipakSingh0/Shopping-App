// ignore_for_file: non_constant_identifier_names, unused_field
import 'package:flutter/material.dart';
import 'package:shop/models/sneakers_model.dart';
import 'package:shop/services/helper.dart';
import 'package:shop/shared/appstyle.dart';
import 'package:shop/shared/home_widget.dart';
// import 'package:shop/shared/new_shoes.dart';
// import 'package:shop/shared/product_cart.dart';

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
    _female = Helper().getFemaleSneakers();
  }

  void getKids() {
    _kids = Helper().getKidsSneakers();
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
    var ScreenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        backgroundColor: Colors.grey.shade400,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                  height: ScreenSize.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/top_image.jpg"),
                          fit: BoxFit.fill)),
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, bottom: 8),
                    width: ScreenSize.width,
                    // height: MediaQuery.of(context).size.height,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Athletics Shoes \n Collection",
                            style: appStyleWithHt(
                                34, Colors.white, FontWeight.bold, 1.5)),
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
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: ScreenSize.height * 0.24),
                child: Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: TabBarView(controller: _tabController, children: [
                    HomeWidget(
                        ScreenSize: ScreenSize, male: _male, tabIndex: 0),
                    HomeWidget(
                        ScreenSize: ScreenSize, male: _female, tabIndex: 1),
                    HomeWidget(
                        ScreenSize: ScreenSize, male: _kids, tabIndex: 2),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
