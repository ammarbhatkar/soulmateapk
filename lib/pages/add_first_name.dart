// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:soulmateapk/components/bottom_border_textfield.dart';
import 'package:soulmateapk/diaogs/welcom_dialog.dart';
import 'package:soulmateapk/utils/custom_color.dart';
import 'package:soulmateapk/widgets/heading1_text.dart';
import 'package:soulmateapk/widgets/normal_button.dart';
import 'package:soulmateapk/widgets/text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class AddFirstName extends StatefulWidget {
  const AddFirstName({super.key});

  @override
  State<AddFirstName> createState() => _AddFirstNameState();
}

class _AddFirstNameState extends State<AddFirstName> {
  final TextEditingController _firstNameController = TextEditingController();
  void _showDialog() {
    showWelcomeDialog(context, _firstNameController);
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
              currentStep: 25,
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
                    SizedBox(height: 40),
                    HeaderText(
                      text: "What's your first name?",
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 40),
                    BottomBorderTextField(
                      controller: _firstNameController,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    HeadingText(
                      text: "This is how it'll appear on your profile. ",
                      color: subHeadingGrey2,
                      fontSize: 14,
                    ),
                    SizedBox(height: 1),
                    HeadingText(
                      text: "Can't change it later.",
                      fontWeight: FontWeight.w700,
                      color: subHeadingGrey2,
                      fontSize: 14,
                    ),
                    Spacer(),
                    ValueListenableBuilder(
                      valueListenable: _firstNameController,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            if (_firstNameController.text.isNotEmpty) {
                              _showDialog();
                            }
                          },
                          child: NormalButton(
                            text: "Next",
                            gradient: _firstNameController.text.isNotEmpty
                                ? LinearGradient(
                                    colors: [
                                      Color(0xfffd267a),
                                      Color(0xffff6036),
                                    ],
                                  )
                                : null,
                            color: _firstNameController.text.isNotEmpty
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
