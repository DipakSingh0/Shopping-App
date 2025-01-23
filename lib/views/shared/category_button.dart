import 'package:flutter/material.dart';
import 'package:shop/views/shared/appstyle.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton(
      {super.key,
      this.onPress,
      required this.buttonColor,
      required this.label});

  final void Function()? onPress;
  final Color buttonColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 45,
        width: 85,
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: buttonColor,
                style: BorderStyle.solid,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(9))),
          child:
              Center(child: Text(label, style: appStyle(12, buttonColor, FontWeight.w600)))),
    );
  }
}
