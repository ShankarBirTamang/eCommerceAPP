import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/views/shared/appstyle.dart';
import 'package:flutter/material.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile({Key? key, required this.imageUrl, required this.name, required this.price, required this.index}) : super(key: key);
  final String imageUrl;
  final String name;
  final String price;
  final int index;
  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.fill,
            ),
            Container(
              padding: const EdgeInsets.only(top: 8),
              height: (widget.index % 2==0)?110:85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(widget.name , style: appStyleWithHegiht(20, Colors.black, FontWeight.w700,1)),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("\$${widget.price}" , style: appStyleWithHegiht(20, Colors.black, FontWeight.w500,1)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
