import 'package:e_commerce/controller/product_provider.dart';
import 'package:e_commerce/views/shared/appstyle.dart';
import 'package:e_commerce/views/shared/category_btn.dart';
import 'package:e_commerce/views/shared/latest_shoes.dart';
import 'package:e_commerce/views/shared/my_spacer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key, required this.tabIndex});
  final int tabIndex;
  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this, initialIndex: widget.tabIndex);

  @override
  void initState() {
    super.initState();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];
  List<String> category = [
    "Running\n Shoes",
    "Football\n Shoes",
    "Tennis\n Shoes",
    "Hiking\n Shoes",
    "Formal\n Shoes",
    "Casual\n Shoes",
    "Boots",
    "Water\n Shoes",
    "School\n Shoes",
    "Leather\n Shoes",
    "Industrial\n Shoes"
  ];
  List<String> gender = ["Male", "Women", "Kids"];
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
                      fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              filter();
                            },
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                  TabBar(
                      padding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: appStyle(24, Colors.white, FontWeight.bold),
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
                      ]),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: 16,
                  right: 12),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(controller: _tabController, children: [
                  LatestShoes(gender: productNotifier.male),
                  LatestShoes(gender: productNotifier.female),
                  LatestShoes(gender: productNotifier.kid),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

// Slider ICON Display
  Future<dynamic> filter() {
    double value = 100;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context) => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                // width: MediaQuery.of(context).size.width*0.95,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Column(
                  verticalDirection: VerticalDirection.down,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 5,
                      width: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black38,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const MySpacer(),
                              Text(
                                "Filter",
                                style:
                                    appStyle(40, Colors.black, FontWeight.bold),
                              ),
                              const MySpacer(),
                              Text("Gender",
                                  style: appStyle(
                                      20, Colors.black, FontWeight.bold)),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              SizedBox(
                                height: 80,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 1,
                                  ),
                                  itemCount: gender.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return CategoryBtn(
                                        buttonClr: Colors.black,
                                        label: gender[index]);
                                  },
                                ),
                              ),
                              const MySpacer(),
                              Text("Category",
                                  style: appStyle(
                                      20, Colors.black, FontWeight.bold)),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              SizedBox(
                                height: 80,
                                child: ListView.builder(
                                  itemCount: category.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: CategoryBtn(
                                            buttonClr: Colors.black,
                                            label: category[index]));
                                  },
                                ),
                              ),
                              const MySpacer(),
                              Text("Price",
                                  style: appStyle(
                                      20, Colors.black, FontWeight.bold)),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              Expanded(
                                child: Slider(
                                    value: value,
                                    activeColor: Colors.green,
                                    inactiveColor: Colors.grey,
                                    thumbColor: Colors.black,
                                    max: 500,
                                    divisions: 50,
                                    label: value.toString(),
                                    secondaryTrackValue: 200,
                                    onChanged: (double value) {}),
                              ),
                              const MySpacer(),
                              Text("Brand",
                                  style: appStyle(
                                      20, Colors.black, FontWeight.bold)),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    itemCount: brand.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          child: Image.asset(
                                            brand[index],
                                            height: 60,
                                            width: 80,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ));
  }
}
