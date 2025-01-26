import 'package:shop/views/shared/export.dart';
import 'package:shop/views/ui/cart_page.dart';

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
