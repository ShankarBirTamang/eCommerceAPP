import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../shared/export.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {

  
  @override
  Widget build(BuildContext context) {
   var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
   favoritesNotifier.getAllData();

    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 30, 0, 0),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/top_image.png"),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "My Favorites",
                style: appStyle(40, Colors.white, FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
                itemCount: favoritesNotifier.fav.length,
                padding: const EdgeInsets.only(top: 100),
                itemBuilder: (context, index) {
                  final shoe = favoritesNotifier.fav[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        child: Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                flex: 1,
                                onPressed: (context) {
                                  favoritesNotifier.deleteFav(shoe['key']);
                                  ids.removeWhere(
                                      (element) => element == shoe['id']);
                                  debugPrint(
                                      "Shoe: ${shoe['name']} is removed.");
                                  Navigator.pushNamed(context, '/main');
                                },
                                backgroundColor: const Color.fromARGB(255, 159, 92, 92),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade500,
                                    blurRadius: 0.3,
                                    spreadRadius: 5,
                                    offset: const Offset(0, 1))
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: CachedNetworkImage(
                                    imageUrl: shoe['imageUrl'],
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 190,
                                        child: Text(
                                          shoe['name'],
                                          overflow: TextOverflow.ellipsis,
                                          style: appStyle(16, Colors.black,
                                              FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        shoe['category'],
                                        style: appStyle(
                                            14, Colors.grey, FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Rs.${shoe['price']}',
                                            style: appStyle(18, Colors.black,
                                                FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        favoritesNotifier.deleteFav(shoe['key']);
                                        favoritesNotifier.ids.removeWhere(
                                            (element) => element == shoe['id']);
                                        debugPrint(
                                            "Shoe: ${shoe['name']} is removed.");
                                       Navigator.pushNamed(context, '/main');
                                      },
                                      child: const Icon(Icons.heart_broken)),
                                ),
                              ],
                            ),
                          ),
                        )),
                  );
                }),
          )
        ],
      ),
    ));
  }
}
