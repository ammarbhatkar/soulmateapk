// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileContainer extends StatelessWidget {
  final String? colorText;
  final String text;
  final Color? color;
  final String icon;
  final String? optionalText;
  final Color textCOlor;
  final double? size;
  final double? optionalSize;
  final FontWeight? fontWeight;
  final FontWeight? optionalFontWeight;

  final bool isThirdContainer;

  final optionalTextColor;
  UserProfileContainer({
    super.key,
    this.colorText,
    required this.text,
    this.color,
    required this.icon,
    this.optionalText,
    this.textCOlor = Colors.white,
    this.optionalTextColor = Colors.white,
    this.size = 12,
    this.optionalSize = 12,
    this.fontWeight = FontWeight.w500,
    this.optionalFontWeight = FontWeight.w500,
    this.isThirdContainer = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          // color: Colors.white,

          color: Color.fromRGBO(27, 31, 37, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              height: 15,
              width: 15,
            ),
            SizedBox(height: 4),
            if (isThirdContainer)
              SizedBox(
                  height:
                      10), // Add space after the icon in the third container

            Row(
              children: [
                Text(colorText ?? "",
                    style: GoogleFonts.inter(
                      fontSize: size,
                      fontWeight: optionalFontWeight,
                      color: color,
                    )),
                SizedBox(width: 2),
                Text(text,
                    style: GoogleFonts.inter(
                      fontSize: size,
                      fontWeight: fontWeight,
                      color: textCOlor,
                    )),
              ],
            ),
            if (optionalText != null) ...[
              // Only render the SizedBox and Text widgets if optionalText is not null
              SizedBox(height: 4),
              Text(
                optionalText ?? "",
                style: GoogleFonts.inter(
                  fontSize: optionalSize,
                  fontWeight: optionalFontWeight,
                  color: optionalTextColor,
                ),
              ),
            ] else ...[
              // Only render the SizedBox and Text widgets if optionalText is null
              // SizedBox(height: 10),
              // SizedBox(height: 6),
              Text(
                "",
                style: GoogleFonts.inter(
                  fontSize: optionalSize,
                  fontWeight: optionalFontWeight,
                  color: optionalTextColor,
                ),
              ),
            ],
          ],
        ),
      ),
      Positioned(
        top: -10,
        right: -10,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Color.fromRGBO(167, 175, 187, 1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(
              "assets/icons/plusicononly.svg",
              height: 12,
              width: 12,
              color: Color.fromRGBO(167, 175, 187, 1),
            ),
          ),
        ),
      )
    ]);
  }
}
