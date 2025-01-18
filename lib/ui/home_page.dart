import 'package:flutter/material.dart';
import 'package:shop/shared/appstyle.dart';
// import 'package:shop/shared/appstyle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding:const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration:const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/top_image.jpg"),
                 fit: BoxFit.fill)
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Athletics Shoes" ,style: appStyleWithHt(42 , Colors.white , FontWeight.bold , 1.5)),
                    Text("Collection" ,style: appStyleWithHt(42 , Colors.white , FontWeight.bold , 1.5)),
                  
                  ],
                ),
              )
            ),
            // ... other children
          ],
        ),
      ),);
  }
}
