// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:soulmateapk/utils/custom_color.dart';

class MyTextField extends StatelessWidget {
  final bool obsecureText;
  final String text;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  const MyTextField({
    super.key,
    required this.text,
    required this.obsecureText,
    required this.controller,
    this.focusNode,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(

                // color: Theme.of(context).colorScheme.primary,
                ),
          ),
          // fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: text,
          hintStyle: TextStyle(
            // color: Theme.of(context).colorScheme.primary,

            color: subHeadingGrey,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
