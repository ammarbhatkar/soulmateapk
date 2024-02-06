// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulmateapk/components/gender_container.dart';
import 'package:soulmateapk/pages/add_photos.dart';
import 'package:soulmateapk/pages/main_page.dart';
import 'package:soulmateapk/services/auth_services.dart';
import 'package:soulmateapk/utils/custom_color.dart';
import 'package:soulmateapk/widgets/normal_button.dart';
import 'package:soulmateapk/widgets/text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class GenderInfo extends StatefulWidget {
  final String firstname;
  final String birthDate;
  const GenderInfo(
      {super.key, required this.firstname, required this.birthDate});

  @override
  State<GenderInfo> createState() => _GenderInfoState();
}

class _GenderInfoState extends State<GenderInfo> {
  final AuthService _auth = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedGender;
  @override
  void initState() {
    super.initState();
    print("firstname: ${widget.firstname}");
    print("birthDate: ${widget.birthDate}");
  }

  void updateUserProfile(String gender) async {
    User? user = await _auth.getCurrentUser();
    if (user != null) {
      _firestore.collection("Users").doc(user.uid).update({
        'gender': gender,
        'firstname': widget.firstname,
        'age': widget.birthDate,
        // add other fields here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            StepProgressIndicator(
              totalSteps: 100,
              currentStep: 75,
              size: 6,
              padding: 0,
              selectedColor: Colors.yellow,
              unselectedColor: Colors.grey,
              roundedEdges: Radius.circular(10),
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xfffd267a),
                  Color(0xffff6036),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: subHeadingGrey2,
                      size: 35,
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: HeaderText(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        text: "Whats your gender?",
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedGender = "Woman"),
                        child: GenderContainer(
                          borderColor: selectedGender == "Woman"
                              ? mainPinkColor
                              : subHeadingGrey,
                          text: "Woman",
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedGender = "Man"),
                        child: GenderContainer(
                          borderColor: selectedGender == "Man"
                              ? mainPinkColor
                              : subHeadingGrey,
                          text: "Man",
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedGender = "More"),
                        child: GenderContainer(
                          borderColor: selectedGender == "More"
                              ? mainPinkColor
                              : subHeadingGrey,
                          text: "More",
                        ),
                      ),
                    ),
                    Spacer(),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          updateUserProfile(selectedGender ?? "");
                          if (selectedGender != null) {
                            Get.offAll(
                              () => AddCustomPhotos(
                                firstname: widget.firstname,
                                birthDate: widget.birthDate,
                                gender: selectedGender ?? "",
                              ),
                            );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => AddCustomPhotos(
                            //       firstname: widget.firstname,
                            //       birthDate: widget.birthDate,
                            //       gender: selectedGender ?? "",
                            //     ),
                            //   ),
                            // );
                          }
                        },
                        child: NormalButton(
                          text: "Next",
                          gradient: selectedGender != null
                              ? LinearGradient(
                                  colors: [
                                    Color(0xfffd267a),
                                    Color(0xffff6036),
                                  ],
                                )
                              : null,
                          color: selectedGender != null
                              ? primaryBackgroundColor
                              : subHeadingGrey,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
