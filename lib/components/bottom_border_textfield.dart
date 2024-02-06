// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BottomBorderTextField extends StatelessWidget {
  final TextEditingController controller;
  const BottomBorderTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 20,
      cursorColor: Colors.black,
      controller: controller,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.all(5),
        isDense: true,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
