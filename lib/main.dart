import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shop/controllers/cart_provider.dart';
import 'package:shop/controllers/favorites_notifier.dart';
import 'package:shop/controllers/product_notifier.dart';
import 'package:shop/views/ui/main_screen.dart';
import 'package:provider/provider.dart';
import 'controllers/mainscreen_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await  Hive.initFlutter();
  await  Hive.openBox('cart_box');
  await  Hive.openBox('fav_box');



  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (context) => ProductNotifier()),
    ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
    ChangeNotifierProvider(create: (context) => CartProvider()),

  ], child: const MyApp()));
}

//---------------to commit -------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
     builder: (context, child) {
     return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HomePage',
        home: MainScreen(),
      );
      }
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'HomePage',
//       home: MainScreen(),
//     );
//   }
// }
