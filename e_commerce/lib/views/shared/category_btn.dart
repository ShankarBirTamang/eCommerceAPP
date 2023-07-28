import 'package:e_commerce/views/shared/appstyle.dart';
import 'package:flutter/material.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({Key? key, this.onPress, required this.buttonClr, required this.label}) : super(key: key);
  final void Function()? onPress ;
  final Color buttonClr ;
  final String label ;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPress,
        child: Card(
          elevation: 4,
          color: Colors.white,
          shadowColor: Colors.black87,
          child: Container(
            
            height: 47,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4),
            width: MediaQuery.of(context).size.width * 0.23,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: buttonClr, style: BorderStyle.none),
                borderRadius: const BorderRadius.all(Radius.circular(9))),
                child: Center(child: Text(label , style: appStyle(13,buttonClr , FontWeight.w600 ),)),
          ),
        ));
  }
}
