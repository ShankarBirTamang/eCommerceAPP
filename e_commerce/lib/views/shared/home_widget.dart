import 'package:e_commerce/controller/product_provider.dart';
import 'package:e_commerce/views/shared/appstyle.dart';
import 'package:e_commerce/views/shared/new_shoes.dart';
import 'package:e_commerce/views/shared/product_card.dart';
import 'package:e_commerce/views/ui/product_by_cat.dart';
import 'package:e_commerce/views/ui/product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/sneakers_model.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> male,
    required this.tabIndex,
  }) : _male = male;

  final Future<List<Sneakers>> _male;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.405,
            child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator.adaptive());
                } else if (snapshot.hasError) {
                  return Text("Error : ${snapshot.error}");
                } else {
                  final male = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: male!.length,
                    itemBuilder: (context, index) {
                      final shoe = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          productNotifier.shoeSizes = shoe.sizes ;
                          // debugPrint("${productNotifier.shoeSizes}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(
                                    id: shoe.id, category: shoe.category),
                              ));
                        },
                        child: ProductCard(
                            name: shoe.name,
                            image: shoe.imageUrl[0],
                            id: shoe.id,
                            price: shoe.price,
                            category: shoe.category),
                      );
                    },
                  );
                }
              },
            )),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Shoes",
                    style: appStyle(24, Colors.black, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint("Tab Index : $tabIndex");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductByCat(tabIndex: tabIndex),
                          ));
                    },
                    child: Row(children: [
                      Text(
                        "Show All",
                        style: appStyle(22, Colors.black, FontWeight.w500),
                      ),
                      const Icon(Icons.arrow_right, size: 26)
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.13,
            child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error : ${snapshot.error}");
                } else {
                  final male = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: male!.length,
                    itemBuilder: (context, index) {
                      final shoe = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NewShoes(imageURL: shoe.imageUrl[1]),
                      );
                    },
                  );
                }
              },
            )),
      ],
    );
  }
}
