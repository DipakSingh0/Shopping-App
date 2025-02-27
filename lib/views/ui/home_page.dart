import 'package:shop/views/shared/export.dart';
import 'package:shop/views/shared/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getMale();
    productNotifier.getFemale();
    productNotifier.getKids();

    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
    favoritesNotifier.getFavorites();

    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          // height: 812,
          // width: 375,
          child: Stack(
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                  height: screenSize.height,
                  // height: 812,
                  // width: 375,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/top_image.jpg"),
                          fit: BoxFit.fill)),
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, bottom: 8),
                    width: screenSize.width,
                    // width: 375,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Athletics Shoes",
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
                padding: EdgeInsets.only(top: screenSize.height * 0.24),
                // padding: EdgeInsets.only(top: 160.h),

                child: Container(
                  // padding: const EdgeInsets.only(left: 8),
                  padding: EdgeInsets.only(left: 8.h),

                  child: TabBarView(controller: _tabController, children: [
                    HomeWidget(
                        ScreenSize: screenSize,
                        male: productNotifier.male,
                        tabIndex: 0),
                    HomeWidget(
                        ScreenSize: screenSize,
                        male: productNotifier.female,
                        tabIndex: 1),
                    HomeWidget(
                        ScreenSize: screenSize,
                        male: productNotifier.kids,
                        tabIndex: 2),
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
