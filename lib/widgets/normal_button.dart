// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalButton extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final Gradient? gradient;
  final double marginLeft; // new property
  final double marginRight; // new property
  final double marginTop; // new property
  final double marginBottom; // new property

  NormalButton({
    super.key,
    required this.text,
    this.size = 18,
    this.fontWeight = FontWeight.w700,
    this.color = const Color.fromRGBO(130, 134, 147, 1),
    this.gradient,
    this.marginLeft = 0, // default value is 0
    this.marginRight = 0, // default value is 0
    this.marginTop = 0, // default value is 0
    this.marginBottom = 0, //
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        marginLeft,
        marginTop,
        marginRight,
        marginBottom,
      ), // a
      decoration: BoxDecoration(
        color: Color.fromRGBO(235, 236, 239, 1),
        borderRadius: BorderRadius.circular(20),
        gradient: gradient,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: size,
              fontWeight: fontWeight,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
