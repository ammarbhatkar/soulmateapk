import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulmateapk/pages/location_page.dart';

class BuildLoginButton extends StatelessWidget {
  final String text;
  final String buttonIcon;
  const BuildLoginButton({
    super.key,
    required this.screenSize,
    required this.text,
    required this.buttonIcon,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0),
      child: Padding(
        padding: EdgeInsets.only(right: 0),
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 0.08 * screenSize.width), // 2% of screen width
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 0.02 * screenSize.height, // 2% of screen height
              bottom: 0.02 * screenSize.height, // 2% of screen height
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 0.05 * screenSize.width), // 5% of screen width
                Image.asset(
                  buttonIcon,
                  height: 0.03 * screenSize.height, // 3% of screen height
                ),
                SizedBox(width: 0.05 * screenSize.width), // 5% of screen width
                Text(
                  text,
                  style: GoogleFonts.inter(
                    fontSize: 0.048 * screenSize.width, // 4.5% of screen width
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(78, 76, 76, 1),
                  ),
                ),
                SizedBox(width: 0.05 * screenSize.width),
// 5% of screen width
              ],
            ),
          ),
        ),
      ),
    );
  }
}
