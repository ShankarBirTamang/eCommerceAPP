import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/export.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getFemale();
    productNotifier.getMale();
    productNotifier.getKid();

    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 30, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/top_image.png"),
                        fit: BoxFit.cover)),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, bottom: 16),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Athletics Shoes",
                        style: appStyleWithHegiht(
                            38, Colors.white, FontWeight.bold, 1.5),
                      ),
                      Text(
                        "Collections ",
                        style: appStyleWithHegiht(
                            34, Colors.white, FontWeight.bold, 1.2),
                      ),
                      TabBar(
                          padding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle:
                              appStyle(24, Colors.white, FontWeight.bold),
                          controller: _tabController,
                          unselectedLabelColor: Colors.grey.withOpacity(0.8),
                          tabs: const [
                            Tab(
                              text: "Men Shoes",
                            ),
                            Tab(
                              text: "Women Shoes",
                            ),
                            Tab(
                              text: "Kids Shoes",
                            ),
                          ])
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.265),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TabBarView(controller: _tabController, children: [
                    HomeWidget(
                      male: productNotifier.male,
                      tabIndex : 0,
                    ),
                    HomeWidget(
                      male: productNotifier.female,
                      tabIndex: 1,
                    ),
                    HomeWidget(
                      male: productNotifier.kid,
                      tabIndex: 2,
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
        
        );
  }
}
