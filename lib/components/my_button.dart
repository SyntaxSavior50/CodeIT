import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;
  final String text;

  const MyButton({super.key,required this.onTap,required this.text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 100),
        decoration: BoxDecoration(
            color: const Color(0xff26b051),
            borderRadius: BorderRadius.circular(20),
            boxShadow:const [
              BoxShadow(
                color: Color(0xff26b051),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(4,4),
              ),
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(-4,-4),
              )
            ]

        ),
        child: Center(
          child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
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
