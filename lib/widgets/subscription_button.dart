// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionButton extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final Color buttonColor;
  SubscriptionButton({
    super.key,
    required this.text,
    this.size = 18,
    this.fontWeight = FontWeight.w700,
    this.color = const Color.fromRGBO(130, 134, 147, 1),
    this.buttonColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
                fontSize: size, fontWeight: fontWeight, color: color),
          ),
        ),
      ),
    );
  }
}
