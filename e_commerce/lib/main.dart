import 'package:e_commerce/controller/cart_provider.dart';
import 'package:e_commerce/controller/favourite_provider.dart';
import 'package:e_commerce/controller/mainscreen_provider.dart';
import 'package:e_commerce/controller/product_provider.dart';
import 'package:e_commerce/views/ui/cartpage.dart';
import 'package:e_commerce/views/ui/favourite_page.dart';
import 'package:e_commerce/views/ui/homepage.dart';
import 'package:e_commerce/views/ui/mainscreen.dart';
import 'package:e_commerce/views/ui/profile.dart';
import 'package:e_commerce/views/ui/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
 
  // Ensure that the necessary Flutter bindings are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');


  runApp(MultiProvider(
    providers : [
      ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
      ChangeNotifierProvider(create: (context) => ProductNotifier()),
      ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of this   application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce APPs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/main',
      routes: {
        '/':(context) => const MainScreen(),
        '/main':(context) => const MainScreen(),
        '/home':(context) => const Homepage(),
        '/search':(context) => const Searchpage(),
        '/cart':(context) =>   CartPage(),
        '/fav':(context) => const FavouritePage(),
        '/profile':(context) => const Profile(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => const MainScreen(),),
      // home: const MainScreen(),
    );
  }
}
