import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realpalooza/Screens/base_screen.dart';
import 'package:realpalooza/pages/login_or_registered.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            //user logged in
            if(snapshot.hasData){
              return const BaseScreen(selectedIndex: 0,);
            }
            //user not logged in
            else{
              return LoginOrRegistered();
            }
          },
        )
    );
  }
}
