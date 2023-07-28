import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controller/cart_provider.dart';
import 'package:e_commerce/controller/favourite_provider.dart';
import 'package:e_commerce/controller/product_provider.dart';
import 'package:e_commerce/models/sneakers_model.dart';
import 'package:e_commerce/views/shared/appstyle.dart';
import 'package:e_commerce/views/shared/checkout_btn.dart';
import 'package:e_commerce/views/shared/my_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.id, required this.category})
      : super(key: key);
  final String id;
  final String category;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  double _rating = 0;

 
 @override
 void initState() {
   super.initState();
 }

  


  @override
  Widget build(BuildContext context) {
      int actPage = 0 ;

    var productNotifier= Provider.of<ProductNotifier>(context , listen:true);
    productNotifier.getShoes(widget.category, widget.id);

    var cartProvider= Provider.of<CartProvider>(context);

    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
    favoritesNotifier.getFavourite();

    return Scaffold(
        body: FutureBuilder<Sneakers>(
            future: productNotifier.sneaker,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error : ${snapshot.error}");
              } else {
                final sneakers = snapshot.data;
                return Consumer<ProductNotifier>(
                  builder: (context, productNotifier, child) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          leadingWidth: 0,
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 0, top: 5),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      productNotifier.shoeSizes.clear();
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                  GestureDetector(
                                    onTap: null,
                                    child:
                                        const Icon(Icons.more_horiz_outlined),
                                  ),
                                ]),
                          ),
                          pinned: true,
                          floating: true,
                          snap: false,
                          backgroundColor: Colors.transparent,
                          expandedHeight:
                              MediaQuery.of(context).size.height * 0.35,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              children: [
                                Positioned(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.grey.shade300,
                                      child: PageView.builder(
                                        itemCount: sneakers!.imageUrl.length,
                                        scrollDirection: Axis.horizontal,
                                        controller: pageController,
                                        onPageChanged: (page) {
                                        
                                          actPage = page ;
                                          // productNotifier.activePa
                                          //ge = page;
                                          debugPrint("page : $page");
                                        },
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      sneakers.imageUrl[index],
                                                      fadeInCurve: Curves.ease,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                // Fav Icon
                                Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.1,
                                    right: 20,
                                    child: Consumer<FavoritesNotifier>(
                                      builder:
                                          (context, favoritesNotifier, child) {
                                        return GestureDetector(
                                          onTap: () async {
                                            if (favoritesNotifier.ids
                                                .contains(widget.id)) {
                                              setState(() {
                                                const Icon(Icons.favorite,
                                                    color: Colors.green);
                                              });

                                              Navigator.pushNamed(context,'/fav');
                                            } else {
                                              favoritesNotifier.createFav({
                                                "id": sneakers.id,
                                                "name": sneakers.name,
                                                "category": sneakers.category,
                                                "price": sneakers.price,
                                                "imageUrl":
                                                    sneakers.imageUrl[0],
                                              });
                                              setState(() {});
                                            }
                                          },
                                          child: favoritesNotifier.ids.contains(sneakers.id)
                                              ? const Icon(Icons.favorite,
                                                  color: Colors.green)
                                              : const Icon(
                                                  Icons.favorite_border,
                                                ),
                                        );
                                      },
                                    )),

                                // Dot Indicator
                                Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.35,
                                    right: 0,
                                    left: 0,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List<Widget>.generate(
                                            sneakers.imageUrl.length, //length
                                            (index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  actPage !=
                                                          index
                                                      ? Colors.grey
                                                      : Colors.black,
                                              radius: 5,
                                            ),
                                          );
                                        }))),
                              ],
                            ),
                          ),
                        ),

                        // Description Section
                        SliverToBoxAdapter(
                            child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))
                              // boxShadow: [BoxShadow(
                              //   color:Colors.black54,
                              //   blurRadius: 5,
                              //   offset: Offset(0,10),
                              //   spreadRadius: 0.5
                              // )]
                              ),
                          // height: MediaQuery.of(context).size.height * 1.1,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // Shoe Name
                                    sneakers.name,
                                    style: appStyle(
                                        30, Colors.white, FontWeight.bold),
                                  ),

                                  //1st row
                                  Row(
                                    children: [
                                      Text(
                                        // Shoe Category
                                        sneakers.category,
                                        style: appStyle(
                                            15, Colors.grey, FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      //Rating Bar
                                      RatingBar.builder(
                                          unratedColor: Colors.white,
                                          initialRating: _rating,
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 20.0,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amberAccent,
                                              ),
                                          onRatingUpdate: (rating) {
                                            setState(() {
                                              _rating = rating;
                                            });
                                          }),
                                    ],
                                  ),

                                  //2nd row
                                  const MySpacer(),
                                  // Shoe Price
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$${sneakers.price}",
                                          style: appStyle(25, Colors.white,
                                              FontWeight.w500),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Colors",
                                              style: appStyle(18, Colors.white,
                                                  FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const CircleAvatar(
                                              radius: 8,
                                              backgroundColor: Colors.blue,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: 14,
                                              width: 14,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7)),
                                                  color: Colors.black,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.white,
                                                      spreadRadius: 1,
                                                    )
                                                  ]),
                                            )
                                          ],
                                        ),
                                      ]),

                                  // Sizes Column and row
                                  const MySpacer(),
                                  Column(children: [
                                    Row(
                                      children: [
                                        Text("Select a size",
                                            style: appStyle(18, Colors.white,
                                                FontWeight.w600)),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text("View size guide",
                                            style: appStyle(15, Colors.grey,
                                                FontWeight.w600)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                        height: 45,
                                        child: ListView.builder(
                                          itemCount:
                                              productNotifier.shoeSizes.length,
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final size = productNotifier
                                                .shoeSizes[index];
                                            return ChoiceChip(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  side: const BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                      style:
                                                          BorderStyle.solid)),
                                              disabledColor: Colors.white,
                                              selectedColor:
                                                  Colors.greenAccent.shade100,
                                              label: Text(size['size'],
                                                  style: appStyle(
                                                      12,
                                                      Colors.black,
                                                      FontWeight.w500)),
                                              selected: size['isSelected'],
                                              onSelected: (newState) {
                                                if (productNotifier.sizes
                                                    .contains(size['size'])) {
                                                  productNotifier.sizes
                                                      .remove(size['size']);
                                                } else {
                                                  productNotifier.sizes
                                                      .add(size['size']);
                                                }
                                                debugPrint(
                                                    "Sizes List :  ${productNotifier.sizes}");
                                                productNotifier
                                                    .toggleCheck(index);
                                              },
                                            );
                                          },
                                        ))
                                  ]),
                                  const SizedBox(height: 5),
                                  const Divider(
                                    indent: 10,
                                    endIndent: 10,
                                    color: Colors.white54,
                                  ),
                                  const MySpacer(),
                                  Text(sneakers.title,
                                      style: appStyle(
                                          20, Colors.white, FontWeight.bold)),
                                  const SizedBox(height: 5),
                                  Text(sneakers.description,
                                      textAlign: TextAlign.justify,
                                      style: appStyle(
                                          15, Colors.white, FontWeight.normal)),
                                  const MySpacer(),

                                  //Add to Cart widget

                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: CheckOutButton(
                                        label: "ADD TO CART",
                                        onTap: () {
                                          cartProvider.createCart({
                                            "id": sneakers.id,
                                            "name": sneakers.name,
                                            "category": sneakers.category,
                                            "imageUrl": sneakers.imageUrl[0],
                                            "price": sneakers.price,
                                            "qty": 1,
                                            "sizes": productNotifier.sizes[0],
                                          });
                                          productNotifier.sizes.clear();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ))
                      ],
                    );
                  },
                );
              }
            }));
  }
}
