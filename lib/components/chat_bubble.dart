import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final  String timest;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.timest,
  });

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.green : Colors.grey.shade500,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: Colors.white, fontFamily: 'Comfortaa',fontSize: 17),
          ),
          SizedBox(height: 5),
          Text(
            timest,
            style: TextStyle(color: Colors.white, fontFamily: 'Comfortaa',fontSize: 10),
          ),
        ],
      ),
    );
  }

}
