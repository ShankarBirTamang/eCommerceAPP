import 'package:e_commerce/views/shared/appstyle.dart';
import 'package:flutter/material.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({
    super.key, required this.label, this.onTap,
  });

final String label ;
final void Function()? onTap ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [BoxShadow(
              color: Color.fromARGB(255, 6, 4, 81),
              spreadRadius: 1.5,
              offset: Offset(2,2),
              blurRadius: 1,
            )],
            color: Color.fromARGB(179, 226, 219, 219)),
            height: 50,
            width: MediaQuery.of(context)
                    .size
                    .width *
                0.9,
            child: Center(
              child: Text(label,
                  style: appStyle(
                      18,
                      Colors.black,
                      FontWeight.w500)),
            )),
      ),
    );
  }
}
