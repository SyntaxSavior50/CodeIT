import 'package:flutter/material.dart';
import 'package:realpalooza/Theme/theme_provider.dart';

class MyButton2 extends StatelessWidget {

  final Function()? onTap;
  final String text;

  const MyButton2({super.key,required this.onTap,required this.text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(
            horizontal: 90,
            vertical: 40
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.8) : Color(0xff40bd86),
          //color: const Color(0xff40bd86),
            borderRadius: BorderRadius.circular(100),

        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                //color: Colors.white,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                //fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Comfortaa'
            ),
          ),
        ),
      ),
    );
  }
}
