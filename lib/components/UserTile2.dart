import 'package:flutter/material.dart';

class UserTile2 extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final String imagePath;
  final void Function()? onAddFriendPressed; // Function to handle Add Friend button press

  const UserTile2({
    Key? key,
    required this.text,
    required this.onTap,
    required this.imagePath,
    this.onAddFriendPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 70,
            width: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.8)
                  : Color(0xff26b051).withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.fromLTRB(30, 40, 30, 0),
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10),
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
                const SizedBox(width: 10), // Adjust as needed
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color(0xff515157)
                              : Color(0xffe4f3ec),
                          fontFamily: 'Comfortaa',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.person_add_alt),
                  onPressed: onAddFriendPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
