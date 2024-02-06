// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulmateapk/pages/add_photos.dart';
import 'package:soulmateapk/pages/swipe_page.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 60, 20, 30),
          // color: Color(0xffd4d8de),
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "So, are you from around \n here?",
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Set your location to see who's in your \n  neighbourhood or beyond. You won't be able to \n match with people otherwise,",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Color.fromRGBO(68, 65, 66, 1),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 223, 222,
                        222), // Change this color to change the border color
                    width: 1, // Change this value to change the border width
                  ),
                  shape: BoxShape
                      .circle, // Change this to BoxShape.rectangle for a rectangular border
                ),
                child: Image.asset(
                  "assets/icons/loclight.png",
                  height: 120,
                  width: 120,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCustomPhotos(),
                    ),
                  );
                },
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xfffd267a),
                      Color(0xffff6036),
                    ]),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Allow",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "How is my location used? ",
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(68, 65, 66, 1),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.arrow_downward,
                      size: 20,
                      weight: 800,
                      color: Color.fromRGBO(68, 65, 66, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
