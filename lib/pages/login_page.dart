// ignore_for_file: prefer_const_constructors, unused_field, avoid_print, no_leading_underscores_for_local_identifiers, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soulmateapk/services/auth_services.dart';
import 'package:soulmateapk/widgets/build_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //auth service instance
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool showmore = false;

  bool isLoading = false;

// sign in with proider
  Future<UserCredential> signInWithGoogle() async {
    try {
      setState(() {
        isLoading = true;
      });

      //sig out previously sined in user so that user can selct different id to sigin
      await GoogleSignIn().signOut();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // get the credential
      final userDocRef =
          _firestore.collection("Users").doc(userCredential.user!.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        // This is the first time the user is signing in, set profileSetup to false
        await userDocRef.set({
          "uid": userCredential.user!.uid,
          "name": userCredential.user!.displayName,
          "email": userCredential.user!.email,
          "photoUrl": userCredential.user!.photoURL,
          "lastSeen": DateTime.now(),
          "profileSetup": false,
        });
      } else {
        // User has already signed in before, don't overwrite profileSetup
        // You can optionally update other fields if needed
        await userDocRef.update({
          "lastSeen": DateTime.now(),
        });
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffff6036),
                Color(0xfffd267a),
              ],
              stops: [0, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                0.05 * screenSize.width, // 5% of screen width
                0.2 * screenSize.height, // 20% of screen height
                0.05 * screenSize.width,
                0 // 5% of screen width
                // 0.02 * screenSize.height, // 2% of screen height
                ),
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/iconname.svg',
                    width: 0.5 * screenSize.width, // 50% of screen width
                  ),
                  Spacer(),
                  Text(
                    "By clicking login, you agree with our \n Terms. Learn how we process your data in \n our Privacy Policy and Cookies Policy.",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: GoogleFonts.inter(
                      fontSize: 0.038 * screenSize.width, // 3% of screen width
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(
                      height: 0.02 * screenSize.height), // 2% of screen height
                  // ... rest of your code
                  GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => LocationPage(),
                      //   ),
                      // );
                    },
                    child: BuildLoginButton(
                      text: "LOG IN WITH GOOGLE",
                      buttonIcon: "assets/icons/google.png",
                      screenSize: screenSize,
                    ),
                  ),
                  SizedBox(height: 0.02 * screenSize.height),

                  if (isLoading)
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ), // 2% of screen height
                  // ... rest of your code
                  if (showmore)
                    BuildLoginButton(
                      screenSize: screenSize,
                      text: "LOG IN WITH FACEBOOK",
                      buttonIcon: "assets/icons/facebook.png",
                    ),

                  SizedBox(
                      height: 0.02 * screenSize.height), // 2% of screen height
                  // ... rest of your code
                  if (showmore)
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PhoneLogin(),
                        //   ),
                        // );
                      },
                      child: BuildLoginButton(
                        screenSize: screenSize,
                        buttonIcon: "assets/icons/phone.png",
                        text: "LOG IN WITH PHONE",
                      ),
                    ),
                  if (showmore)
                    SizedBox(
                      height: 20,
                    ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showmore = !showmore;
                      });
                    },
                    child: Text(
                      showmore ? "Trouble logging in?" : "More Options",
                      style: GoogleFonts.inter(
                        fontSize:
                            0.043 * screenSize.width, // 4% of screen width
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 0.05 * screenSize.height),
                  // 3.75% of screen height
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
