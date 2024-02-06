// ignore_for_file: empty_catches, unused_element

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance of auth service
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //sign out

  Future<void> signout() async {
    return await _auth.signOut();
  }

  // sign in with proider
  void _handleGoogleSignin() {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    } catch (e) {
      print(e);
    }
  }
}
