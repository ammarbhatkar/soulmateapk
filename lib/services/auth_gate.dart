// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soulmateapk/pages/add_first_name.dart';
import 'package:soulmateapk/pages/location_page.dart';
import 'package:soulmateapk/pages/login_page.dart';
import 'package:soulmateapk/pages/main_page.dart';
import 'package:soulmateapk/services/chats/chat_services.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final ChatServices _chatServices = ChatServices();
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: StreamBuilder(
            stream: _chatServices.getUserStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MainPage();
              } else {
                return LoginPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
