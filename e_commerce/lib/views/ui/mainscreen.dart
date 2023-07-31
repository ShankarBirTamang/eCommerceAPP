import 'package:e_commerce/controller/mainscreen_provider.dart';
import 'package:e_commerce/views/shared/bottom_nav.dart';
import 'package:e_commerce/views/shared/curved_navBar.dart';
import 'package:e_commerce/views/ui/cartpage.dart';
import 'package:e_commerce/views/ui/favourite_page.dart';
import 'package:e_commerce/views/ui/homepage.dart';
import 'package:e_commerce/views/ui/profile.dart';
import 'package:e_commerce/views/ui/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pageList =  [
    const Homepage(),
    const Searchpage(),
    const FavouritePage(),
    const CartPage(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
            backgroundColor: const Color(0xFFE2E2E2),
            body: pageList[mainScreenNotifier.pageIndex],
            bottomNavigationBar: const CurvedNavBar());
            // bottomNavigationBar: const BottomNavBar());
      },
    );
  }
}
