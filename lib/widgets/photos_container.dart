// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PhotosContainer extends StatelessWidget {
  final String iconPath;
  final String? imagePath;

  final VoidCallback? onRemove;
  const PhotosContainer({
    super.key,
    this.iconPath = 'assets/icons/photoaddicon.svg',
    this.imagePath,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(imagePath!),
                fit: BoxFit.fill,
                width: 100,
                height: 140,
              ),
            ),
            Positioned(
              bottom: -15,
              right: -15,
              child: InkWell(
                onTap: () {
                  print("onRemove is called");
                  // Remove the image
                  onRemove!();
                },
                child: SvgPicture.asset(
                  'assets/icons/removephotoicon.svg',
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(0), // adjust this value as needed
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          color: Color(0xffB9BFC8),
          strokeWidth: 2,
          dashPattern: [
            6,
            3,
          ],
          child: Container(
            width: 100,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // border: Border.all(
              //   color: Color(0xffDCDFE6),
              //   width: 2,
              // ),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.grey[50]!,

                  Color.fromRGBO(235, 236, 239, 1), // slightly dark grey
                ],
              ),

              // color: Color(0xffE4E6EC),
            ),
            // child: imagePath != null
            //     ? ClipRRect(
            //         child: Image.file(
            //           File(imagePath!),
            //           fit: BoxFit.fill,
            //         ),
            //       )
            // child: Container(),

            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: -15,
                  right: -15,
                  child: InkWell(
                    onTap: () {
                      print("onRemove is called");
                      if (imagePath != null) {
                        // Remove the image
                        onRemove!();
                      }
                    },
                    child: SvgPicture.asset(
                      iconPath,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
