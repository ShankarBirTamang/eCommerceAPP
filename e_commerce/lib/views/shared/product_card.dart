import 'package:e_commerce/controller/favourite_provider.dart';
import 'package:e_commerce/views/shared/appstyle.dart';
import 'package:e_commerce/views/ui/favourite_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {Key? key,
      required this.name,
      required this.image,
      required this.id,
      required this.price,
      required this.category})
      : super(key: key);
  final String name;
  final String image;
  final String id;
  final String price;
  final String category;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    var favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifier.getFavourite();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.65,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 0.6,
              offset: Offset(0, 1),
            )
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () async {
                           setState(() {});
                          debugPrint(
                              "Tapped : ${favoritesNotifier.ids} contains ? ${widget.id}");

                          if (favoritesNotifier.ids.contains(widget.id)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FavouritePage(),
                                ));
                          } else {
                            favoritesNotifier.createFav({
                              "id": widget.id,
                              "name": widget.name,
                              "category": widget.category,
                              "price": widget.price,
                              "imageUrl": widget.image,
                            });
                          }
                           
                        },
                        child: favoritesNotifier.ids.contains(widget.id)
                            ? const Icon(Icons.favorite, color: Colors.green)
                            : const Icon(
                                Icons.favorite_border,
                              ),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name,
                        style: appStyleWithHegiht(
                            25, Colors.black, FontWeight.bold, 1.1)),
                    Text(widget.category,
                        style: appStyleWithHegiht(
                            18, Colors.grey, FontWeight.normal, 1.5)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${widget.price}",
                        style: appStyle(25, Colors.black, FontWeight.w600)),
                    Row(
                      children: [
                        Text(
                          "Colors",
                          style: appStyle(14, Colors.grey, FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 0.5,
                        ),
                        SizedBox(
                          height: 28,
                          child: ChoiceChip(
                            label: const Text(""),
                            selected: selected,
                            visualDensity: VisualDensity.compact,
                            selectedColor: Colors.black,
                            shape: const CircleBorder(),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
