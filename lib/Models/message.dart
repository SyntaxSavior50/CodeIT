import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderID;
  final String recieverID;
  final String senderEmail;
  final String message;
  final Timestamp timestamp;
  final String timest;

  Message({
    required this.senderEmail,
    required this.message,
    required this.senderID,
    required this.recieverID,
    required this.timestamp,
    required this.timest,
  });

  Map<String,dynamic> toMap(){
    return{
      'senderID' : senderID,
      'senderEmail' : senderEmail,
      'recieverId' : recieverID,
      'message' : message,
      'timestamp' : timestamp,
      'timest' : timest,
    };
  }


}