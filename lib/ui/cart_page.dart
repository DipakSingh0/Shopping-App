import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: const Center(
              child: Text("Cart Screen",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)))),
    );
  }
}
