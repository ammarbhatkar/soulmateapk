// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                User? user = FirebaseAuth.instance.currentUser;
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(user!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      DocumentSnapshot<Object?>? userDoc = snapshot.data;
                      var userData = userDoc!.data() as Map<String, dynamic>?;
                      if (userDoc.exists &&
                          userData != null &&
                          userData.containsKey('profileSetup') &&
                          userData['profileSetup'] == true) {
                        return MainPage();
                      } else {
                        return AddFirstName(); // or any other page where the user can enter their details
                      }
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return CircularProgressIndicator(); // show a loading spinner while waiting for the data
                    }
                  },
                );
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
