import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controller/cart_provider.dart';
import 'package:e_commerce/controller/mainscreen_provider.dart';
import 'package:e_commerce/models/constants.dart';
import 'package:e_commerce/views/shared/appstyle.dart';
import 'package:e_commerce/views/shared/checkout_btn.dart';
import 'package:e_commerce/views/ui/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
 const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var mainScreenNotifier = Provider.of<MainScreenNotifier>(context);
    var cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCart();

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    mainScreenNotifier.pageIndex = 0;
                    //  Navigator.pushNamed(context, '/home');
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "My Cart",
                  style: appStyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                    itemCount: cartProvider.cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final cData = cartProvider.cart[index];
                      // debugPrint("CData: $cData");
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  onPressed: (_) {
                                    cartProvider.deleteCart(cData['key']);
                                    ids.removeWhere(
                                        (element) => element == cData['id']);
                                    debugPrint(
                                        "Shoe: ${cData['name']} is removed.");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreen()));
                                  },
                                  backgroundColor: const Color(0xFF000000),
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
                                      spreadRadius: 5,
                                      blurRadius: 0.3,
                                      offset: const Offset(0, 1),
                                    )
                                  ]),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: CachedNetworkImage(
                                              imageUrl: cData['imageUrl'],
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.fill,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12, left: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                                width: 160,
                                                child: Text(cData['name'],
                                                    style: appStyle(
                                                        15,
                                                        Colors.black,
                                                        FontWeight.bold)),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                cData['category'],
                                                style: appStyle(14, Colors.grey,
                                                    FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Rs.${cData['price']}",
                                                    style: appStyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Size : ${cData['sizes']}",
                                                    style: appStyle(
                                                        14,
                                                        Colors.black,
                                                        FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      cartProvider.decrement(
                                                          cData['key']);
                                                    });
                                                  },
                                                  child: const Padding(
                                                    padding:  EdgeInsets.all(2.0),
                                                    child:  Icon(
                                                      Icons.remove_circle,
                                                      size: 20,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  cData['qty'].toString(),
                                                  style: appStyle(
                                                      16,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      cartProvider.increment(
                                                          cData['key']);
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.add_circle,
                                                    size: 20,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CheckOutButton(label: "Proceed to Checkout"),
            )
          ],
        ),
      ),
    );
  }
}
