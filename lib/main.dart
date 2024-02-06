// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:soulmateapk/firebase_options.dart';
import 'package:soulmateapk/pages/add_first_name.dart';
import 'package:soulmateapk/pages/add_photos.dart';
import 'package:soulmateapk/pages/login_page.dart';
import 'package:soulmateapk/pages/main_page.dart';
import 'package:soulmateapk/pages/swipe_page.dart';
import 'package:soulmateapk/services/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: AuthGate(),
    );
  }
}
