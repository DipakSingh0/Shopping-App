import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/controllers/mainscreen_notifier.dart';
import 'package:shop/views/shared/bottom_nav_bar.dart';
import 'package:shop/views/ui/cart_page.dart';
import 'package:shop/views/ui/favorites.dart';
import 'package:shop/views/ui/home_page.dart';
import 'package:shop/views/ui/profile_page.dart';
import 'package:shop/views/ui/search_page.dart';

// import 'product_by_cart.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    // const HomePage(),
    const Favorites(),
    CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // int pageIndex = 2;

    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
      return Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: pageList[mainScreenNotifier.pageIndex],
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}