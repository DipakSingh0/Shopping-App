import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/controllers/mainscreen_notifier.dart';
import 'package:shop/shared/bottom_nav_bar.dart';
import 'package:shop/ui/cart_page.dart';
import 'package:shop/ui/home_page.dart';
import 'package:shop/ui/profile_page.dart';
import 'package:shop/ui/search_page.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = const [
    HomePage(),
    SearchPage(),
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // int pageIndex = 2;

    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
      return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: pageList[mainScreenNotifier.pageIndex],
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}
