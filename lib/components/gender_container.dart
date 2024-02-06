import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulmateapk/utils/custom_color.dart';

class GenderContainer extends StatelessWidget {
  final String text;
  final Color borderColor;
  const GenderContainer({
    super.key,
    required this.text,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: subHeadingGrey2,
            ),
          ),
        ),
      ),
    );
  }
}
