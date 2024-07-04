import 'package:flutter/material.dart';

class Mytextfield2 extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscuretext;
  final FocusNode? focusNode;

  const Mytextfield2({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscuretext,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscuretext,
        focusNode: focusNode,
        decoration: InputDecoration(
          enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).brightness == Brightness.dark ?  Colors.white.withOpacity(.8) :  Color(0xff26b051),fontFamily: 'Comfortaa'),
        ),
      ),
    );
  }
}
