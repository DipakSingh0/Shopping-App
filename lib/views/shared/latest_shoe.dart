import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shop/models/sneakers_model.dart';
import 'package:shop/views/shared/stagger_tile.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
        future: _male,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final male = snapshot.data;
            return MasonryGridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 16,
              itemCount: male!.length,
              itemBuilder: (context, index) {
                final shoe = snapshot.data![index];
                return StaggerTile(
                  imageUrl: shoe.imageUrl[0],
                  name: shoe.name,
                  price: "Rs.${shoe.price}",
                );
              },
            );
          }
        });
  }
}
