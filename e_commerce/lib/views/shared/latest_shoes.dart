import 'package:e_commerce/models/sneakers_model.dart';
import 'package:e_commerce/views/shared/stagger_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Sneakers>> gender,
  }) : _male = gender;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
      future: _male,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error : ${snapshot.error}");
        } else {
          final male = snapshot.data;
          return MasonryGridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            scrollDirection: Axis.vertical,
            itemCount: male!.length,
            itemBuilder: (context, index) {
              final shoe = snapshot.data![index];
              return StaggerTile(
                  index: index,
                  imageUrl: shoe.imageUrl[1],
                  name: shoe.name,
                  price: shoe.price);
            },
          );
        }
      },
    );
  }
}
