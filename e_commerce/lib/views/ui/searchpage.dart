import 'package:e_commerce/views/shared/appstyle.dart';
import 'package:flutter/material.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({ Key? key }) : super(key: key);

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Center(
        child : Text("This is SearchPage.",style:appStyle(40 , Colors.black,FontWeight.bold),)
      )
    );
  }
}