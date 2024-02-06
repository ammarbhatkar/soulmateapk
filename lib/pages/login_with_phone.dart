// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:soulmateapk/widgets/normal_button.dart';
import 'package:soulmateapk/widgets/text_header.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Color.fromRGBO(130, 134, 147, 1),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Column(
          children: [
            HeaderText(
              text: "My number is",
              color: Color.fromRGBO(1, 1, 0, 1),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    child: Text("+62"),
                  ),
                  Container(
                    child: Text("Phone Number"),
                  )
                ],
              ),
            ),
            Text(
                "We will send a text with a verification code. Message and data rates may apply.the verified phone number can be used to log in. Learn what happens when your number changes."),
            NormalButton(
              text: "Next",
            )
          ],
        ),
      ),
    );
  }
}
