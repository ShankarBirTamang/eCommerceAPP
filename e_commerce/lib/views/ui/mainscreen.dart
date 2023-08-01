import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/export.dart';

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
    // const CartPage(),
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
