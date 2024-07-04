import 'package:flutter/material.dart';

class Comment extends StatelessWidget{
  final String message;
  final String user;
  //final String time;
  const Comment({
    super.key,
    required this.message,
    required this.user,
    //required this.time
  });

  @override
  Widget build(BuildContext context){
    return
      Container(
      decoration :BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin:EdgeInsets.only(top: 25,left: 25,right: 25),
      padding:EdgeInsets.all(25),
      child:
      Row(
            children: [
              Container(
                  decoration:
                  BoxDecoration(shape: BoxShape.circle,color:Colors.grey[400]),
                child: Icon(Icons.person),
              ),
              Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(user,
                style: TextStyle(color: Colors.grey[500])),
                const SizedBox(height: 10),
                Text(message),
              ]

              )
            ],
    )
    );
  }
}