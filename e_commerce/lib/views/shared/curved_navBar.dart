import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce/controller/mainscreen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurvedNavBar extends StatefulWidget {
  const CurvedNavBar({Key? key}) : super(key: key);

  @override
  State<CurvedNavBar> createState() => _CurvedNavBarState();
}

class _CurvedNavBarState extends State<CurvedNavBar> {
  final items = [
    const Icon(
      Icons.home,
      size: 25,
      color: Colors.white,
    ),
    const Icon(
      Icons.search,
      size: 25,
      color: Colors.white,
    ),
    const Icon(
      Icons.favorite,
      size: 25,
      color: Colors.white,
    ),
    const Icon(
      Icons.shopping_cart,
      color: Colors.white,
      size: 25,
    ),
    const Icon(
      Icons.settings,
      size: 25,
      color: Colors.white,
    ),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
      return CurvedNavigationBar(
        items: items,
        index: index,
        onTap: (index) {
          mainScreenNotifier.pageIndex = index;
        },
        buttonBackgroundColor: Colors.black87,
        color: Colors.black87,
        backgroundColor: const Color.fromARGB(255, 138, 182, 253),
        height: 55,
      );
    });
  }
}
