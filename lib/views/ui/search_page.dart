

import 'package:shop/views/shared/export.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child: Text("SearchPage",
                  style: appStyle(40, Colors.black, FontWeight.bold)))),
    );
  }
}
