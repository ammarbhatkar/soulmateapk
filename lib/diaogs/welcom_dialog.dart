// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulmateapk/pages/birthday_page.dart';
import 'package:soulmateapk/utils/custom_color.dart';
import 'package:soulmateapk/widgets/heading1_text.dart';
import 'package:soulmateapk/widgets/normal_button.dart';
import 'package:soulmateapk/widgets/text_header.dart';

void showWelcomeDialog(BuildContext context, TextEditingController controller) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 40),
            Image.asset('assets/images/waving-hand.png', height: 50),

            SizedBox(height: 25), // welcome image
            Center(
              child: HeaderText(
                text: 'Welcome, ${controller.text}!',
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 10), // welcome message
            HeadingText(
              text: "There's a lot there to discover. But",
              fontSize: 15,
              color: subHeadingGrey,
            ),
            HeadingText(
              text: "let's get your profile setup first.",
              fontSize: 14,
              color: subHeadingGrey,
            ),

            SizedBox(height: 20), // your message
            GestureDetector(
              onTap: () {
                Get.offAll(() => BirthdayPage(firstname: controller.text));
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => BirthdayPage(
                //         firstname: controller.text,
                //       ),
                //     ));
              },
              child: NormalButton(
                text: 'Let\'s go',
                marginLeft: 60,
                marginRight: 60,
                gradient: LinearGradient(
                  colors: [
                    Color(0xfffd267a),
                    Color(0xffff6036),
                  ],
                ),
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: HeadingText(
                text: "Edit name",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: subHeadingGrey2,
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      );
    },
  );
}
