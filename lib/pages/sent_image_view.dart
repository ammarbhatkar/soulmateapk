import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SentImageView extends StatefulWidget {
  final String image;
  const SentImageView({super.key, required this.image});

  @override
  State<SentImageView> createState() => _SentImageViewState();
}

class _SentImageViewState extends State<SentImageView> {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 5.0,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image.network(
            widget.image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
