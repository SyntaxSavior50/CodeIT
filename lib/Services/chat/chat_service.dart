import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:realpalooza/Models/message.dart';

class ChatService {

  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;


  //get user stream
  Stream<List<Map<String,dynamic>>> getUserStream(){
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send message
  Future<void>sendMessage(String recieverID,message) async{
    final String currentUserID = currentUser.email!;
    final String currentUserEmail = currentUser.email!;
    final Timestamp timestamp = Timestamp.now();
    final String timest = DateTime.now().hour.toString()+':'+(DateTime.now().minute.toString().length==1?'0'+DateTime.now().minute.toString():DateTime.now().minute.toString());

    Message newMessage = Message(
      senderEmail: currentUserEmail,
      message: message,
      senderID: currentUserID,
      recieverID: recieverID,
      timestamp: timestamp,
      timest : timest,
    );

    List<String> ids = [currentUserID,recieverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());

  }

  Stream<QuerySnapshot> getMessages(String userID,otherUserID){
    List<String>ids = [userID,otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore
            .collection("chat_rooms")
            .doc(chatRoomID)
            .collection("messages")
            .orderBy("timestamp",descending: false)
            .snapshots();
  }


}