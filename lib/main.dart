import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shop/controllers/product_notifier.dart';
import 'package:shop/ui/main_screen.dart';
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

  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomePage',
      home: MainScreen(),
    );
  }
}
