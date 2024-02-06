// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soulmateapk/widgets/heading1_text.dart';

class CustomImageCaptureOptions extends StatefulWidget {
  const CustomImageCaptureOptions({super.key});

  @override
  State<CustomImageCaptureOptions> createState() =>
      _CustomImageCaptureOptionsState();
}

class _CustomImageCaptureOptionsState extends State<CustomImageCaptureOptions> {
  ImagePicker picker = ImagePicker();
  Future<void> pickImageFromGallery() async {
    final x = await picker.pickImage(source: ImageSource.gallery);
    Navigator.pop(context, x);
  }

  Future<void> captureImageFromCamera() async {
    final x = await picker.pickImage(source: ImageSource.camera);
    Navigator.pop(context, x);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/removexvector.svg",
                height: 24,
                color: Colors.black,
              ),
              SizedBox(height: 20),
              Text(
                "Create New",
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 2),
              HeadingText(text: "Select a content type"),
              Spacer(),
              InkWell(
                onTap: () {
                  pickImageFromGallery();
                },
                child: Image.asset("assets/images/pickgallery.jpeg"),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  captureImageFromCamera();
                },
                child: Image.asset("assets/images/camera_option1.jpeg"),
              ),
              SizedBox(height: 20),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
