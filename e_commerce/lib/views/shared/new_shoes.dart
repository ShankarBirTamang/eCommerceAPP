import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class NewShoes extends StatelessWidget {
  const NewShoes({
    super.key, required this.imageURL,
  });
  final String imageURL ;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 1,
                offset: Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.all(
                Radius.circular(16))),
        height: MediaQuery.of(context).size.height *
            0.13,
        width: MediaQuery.of(context).size.width *
            0.28,
        child: CachedNetworkImage(
          imageUrl: imageURL ,
        ));
  }
}
