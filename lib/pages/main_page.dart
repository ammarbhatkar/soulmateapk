// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soulmateapk/pages/chat_home.dart';
import 'package:soulmateapk/pages/chat_page.dart';
import 'package:soulmateapk/pages/interest_category.dart';
import 'package:soulmateapk/pages/location_page.dart';
import 'package:soulmateapk/pages/main_pages/like_star_page.dart';
import 'package:soulmateapk/pages/main_pages/verify_profile_page.dart';
import 'package:soulmateapk/pages/swipe_page.dart';
import 'package:soulmateapk/pages/user_profile.dart';

class MainPage extends StatefulWidget {
  List<XFile?>? selectedImages = [];
  MainPage({
    super.key,
    this.selectedImages,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> pages;
  int currentIndex = 0;
  bool isDetailedUserInfoVisible = false;

  void toggleDetailedUserInfo() {
    setState(() {
      isDetailedUserInfoVisible = !isDetailedUserInfoVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    pages = [
      SwipePage(
        selectedImages: widget.selectedImages?.whereType<XFile>().toList(),
      ),
      // InterestPage(),
      VerifyProfilePage(),
      LikeStarPage(),
      ChatHome(),
      UserProfileView(),
    ];
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Color.fromARGB(255, 90, 181, 25),
        unselectedItemColor: Color.fromARGB(255, 11, 15, 129).withOpacity(0.3),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/tindericongrey.svg",
              width: 22.568,
              height: 26.872,
              color: currentIndex == 0 ? Color(0xffEA4080) : Color(0xff7D848F),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Search.svg",
              width: 28.069,
              height: 23.853,
              color: currentIndex == 1 ? Color(0xffEA4080) : Color(0xff7D848F),
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Star.svg",
              width: 27.208,
              height: 27.208,
              color: currentIndex == 2 ? Color(0xffEA4080) : Color(0xff7D848F),
            ),
            label: "Star",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/message.svg",
              width: 30.903,
              height: 26.841,
              color: currentIndex == 3 ? Color(0xffEA4080) : Color(0xff7D848F),
            ),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/profileicon.svg",
              width: 19.461,
              height: 26.032,
              color: currentIndex == 4 ? Color(0xffEA4080) : Color(0xff7D848F),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
