// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:soulmateapk/botom_pages/first.dart';
import 'package:soulmateapk/botom_pages/seco.dart';

class BottomPAge extends StatefulWidget {
  const BottomPAge({super.key});

  @override
  State<BottomPAge> createState() => _BottomPAgeState();
}

class _BottomPAgeState extends State<BottomPAge> {
  List pages = [FirstPage(), SeconfPage()];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.3),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.apps)),
          BottomNavigationBarItem(
              label: "bar", icon: Icon(Icons.bar_chart_sharp)),
          BottomNavigationBarItem(label: "search", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "my", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
