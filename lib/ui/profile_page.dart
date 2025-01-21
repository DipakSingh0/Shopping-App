import 'package:flutter/material.dart';
import 'package:shop/shared/appstyle.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child: Text("Profile",
                  style: appStyle(40, Colors.black, FontWeight.bold)))),
    );
  }
}
