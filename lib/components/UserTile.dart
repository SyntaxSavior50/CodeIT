import 'package:flutter/material.dart';


class UserTile extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  final String imagePath;

  const UserTile({
    super.key,
    required this.text,
    required this.ontap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: GestureDetector(
          onTap:ontap,
          child: Container(
            height: 70,
            width: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.8) : Color(0xff26b051).withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.fromLTRB(30, 40, 30, 0),
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const SizedBox(height:  5,),
                Row(
                  children: [
                    const SizedBox(width: 10,),
                    Container(
                      width: 50,
                      height: 50,
                      child: ClipOval(
                        child: Image.network(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 23,),
                    Column(
                      children: [
                        Text(
                          text,
                          style:  TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark ? Color(0xff515157) : Color(0xffe4f3ec),
                            fontFamily: 'Comfortaa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 19,),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
