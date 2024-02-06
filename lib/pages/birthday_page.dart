// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulmateapk/pages/gender_info.dart';
import 'package:soulmateapk/utils/custom_color.dart';
import 'package:soulmateapk/widgets/heading1_text.dart';
import 'package:soulmateapk/widgets/normal_button.dart';
import 'package:soulmateapk/widgets/text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BirthdayPage extends StatefulWidget {
  final String firstname;

  const BirthdayPage({
    super.key,
    required this.firstname,
  });
  @override
  State<BirthdayPage> createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> {
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("firstname: ${widget.firstname}");
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
              currentStep: 50,
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
                    SizedBox(height: 30),
                    // Icon(
                    //   Icons.arrow_back,
                    //   color: subHeadingGrey2,
                    //   size: 35,
                    // ),
                    SizedBox(height: 10),
                    HeaderText(
                      text: "Your age?",
                      fontSize: 32,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _ageController,
                      cursorColor: Colors.black, // make the cursor black
                      decoration: InputDecoration(
                        hintText: "Enter your age",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // make the border black
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 75, 74,
                                  74)), // make the border black when focused
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.all(20),
                        hintStyle: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                    SizedBox(height: 20),
                    HeadingText(
                      text: "  Your profile shows your age.",
                      color: subHeadingGrey2,
                    ),
                    Spacer(),
                    ValueListenableBuilder(
                      valueListenable: _ageController,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => GenderInfo(
                            //       firstname: widget.firstname,
                            //       birthDate: _ageController.text,
                            //     ),
                            //   ),
                            // );
                            Get.offAll(() => GenderInfo(
                                  firstname: widget.firstname,
                                  birthDate: _ageController.text,
                                ));
                          },
                          child: NormalButton(
                            text: "Next",
                            gradient: _ageController.text.isNotEmpty
                                ? LinearGradient(
                                    colors: [
                                      Color(0xfffd267a),
                                      Color(0xffff6036),
                                    ],
                                  )
                                : null,
                            color: _ageController.text.isNotEmpty
                                ? Colors.white
                                : Color.fromRGBO(130, 134, 147, 1),
                          ),
                        );
                      },
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
