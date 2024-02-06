// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulmateapk/pages/add_photos.dart';
import 'package:soulmateapk/pages/chat_page.dart';
import 'package:soulmateapk/pages/swipe_page.dart';
import 'package:soulmateapk/services/auth_gate.dart';
import 'package:soulmateapk/services/auth_services.dart';
import 'package:soulmateapk/utils/custom_color.dart';
import 'package:soulmateapk/widgets/normal_button.dart';
import 'package:soulmateapk/widgets/subscription_button.dart';
import 'package:soulmateapk/widgets/user_profile_builder_pages.dart';
import 'package:soulmateapk/widgets/user_profile_container.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final PageController _pageController = PageController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Timer? _timer;
  int _currentPageIndex = 0;
  int pageIndexNav = 0;
  String? imageUrl;
  String? userName;
  String? userAge;
  void onTap(int index) {
    setState(() {
      pageIndexNav = index;
    });
  } // add this line

  void getImageProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    _firestore.collection("Users").doc(user!.uid).get().then((value) {
      if (value.exists) {
        setState(() {
          imageUrl = value.data()!['images'][0];
          userName = value.data()!['firstname'];
          userAge = value.data()!['age'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getImageProfile();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPageIndex == 2) {
        // modify this line
        _pageController.animateToPage(0,
            duration: Duration(milliseconds: 80), curve: Curves.easeInOut);
        _currentPageIndex = 0; // add this line
      } else {
        _pageController.nextPage(
            duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
        _currentPageIndex++; // add this line
      }
    });
    //  if (_pageController.page!.toInt() == 2) {
    //     _pageController.jumpToPage(0);
    //   } else {
    //     _pageController.nextPage(
    //         duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
    //   }
    // });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
      // backgroundColor: Color.fromRGBO(245, 247, 250, 1),
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        // backgroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/iconname.svg",
              width: 92.708,
              height: 21.999,
              color: Color(
                0xffEA4080,
              ),
            ),
            Spacer(),
            SvgPicture.asset(
              "assets/icons/Vector.svg",
              color: Color(0xff7D848F),
              height: 28,
              width: 28,
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () async {
                // Show CircularProgressIndicator

                // Perform signout
                await _auth.signout();

                // Close the CircularProgressIndicator dialog

                // Navigate to AuthGate
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthGate()),
                );
              },

              child: Icon(
                Icons.logout_rounded,
                size: 28,
                color: Color(0xff7D848F),
              ),
              // child: SvgPicture.asset(
              //   "assets/icons/newsett.svg",
              //   height: 28,
              //   width: 28,
              //   color: Color(0xff7D848F),
              // ),
            ),
            SizedBox(
                // width: 10,
                ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                  // color: Colors.white,
                  color: Color.fromRGBO(27, 31, 37, 1),
                  border: Border(
                    bottom: BorderSide(
                      // color: Color.fromRGBO(245, 247, 250, 1),

                      color: Color.fromRGBO(27, 31, 37, 1),
                      width: 2,
                    ),
                  )),
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 120, // adjust as needed
                          width: 200, // adjust as needed
                          child: SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                interval: 10,
                                startAngle: 125,
                                endAngle: 415,
                                showTicks: false,
                                showLabels: false,
                                axisLineStyle: AxisLineStyle(
                                  thickness: 5,
                                  color: Color.fromRGBO(52, 52, 51, 1),
                                ),
                                pointers: <GaugePointer>[
                                  RangePointer(
                                    value: 26,
                                    width: 5,
                                    gradient: const SweepGradient(
                                      colors: <Color>[
                                        Color(0xfffd267a),
                                        Color(0xffff6036),
                                      ],
                                    ),
                                    // color: Color(0xFFFFCD60),
                                    enableAnimation: true,
                                    cornerStyle: CornerStyle.bothCurve,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // SvgPicture.asset(
                        //   "assets/icons/imagecircle.svg",
                        //   height: 120,
                        //   width: 200,
                        //   color: Color.fromRGBO(236, 104, 101, 1),
                        // ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 49, // adjust as needed
                          backgroundImage: imageUrl != null
                              ? NetworkImage(imageUrl!)
                              : AssetImage("assets/images/emptyprofile.png")
                                  as ImageProvider,
                        ),
                        Positioned(
                          top: 8,
                          right: 20,
                          child: SvgPicture.asset(
                            "assets/icons/editprofileicon.svg",
                            height: 58,
                            width: 58,
                          ),
                        ),
                        Positioned(
                          bottom: -9.5,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xfffd267a),
                                Color(0xffff6036),
                              ]),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Text(
                                "26% COMPLETE",
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userName.toString() + ",",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            // color: Color.fromRGBO(68, 65, 66, 1),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          userAge.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            // color: Color.fromRGBO(68, 65, 66, 1),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              // color: Color.fromRGBO(245, 247, 250, 1),
              color: Colors.black,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // SvgPicture.asset(
                      //   "assets/icons/rectanglevector.svg",
                      //   height: 90,
                      // ),
                      // SvgPicture.asset(
                      //   "assets/icons/rectanglevector.svg",
                      //   height: 90,
                      // ),
                      // SvgPicture.asset(
                      //   "assets/icons/rectanglevector.svg",
                      //   height: 90,
                      // ),

                      UserProfileContainer(
                        icon: 'assets/icons/starvectoricon.svg',
                        colorText: '2',
                        text: 'Super',
                        size: 14,
                        optionalText: "Likes",
                        color: starBlue,
                        optionalFontWeight: FontWeight.w700,
                        fontWeight: FontWeight.w500,
                      ),
                      Spacer(),
                      // SizedBox(width: 5),
                      UserProfileContainer(
                        icon: 'assets/icons/boostvectoricon.svg',
                        text: 'My Boosts',
                        optionalText: "Get More",
                        size: 12,
                        optionalFontWeight: FontWeight.w800,
                        optionalTextColor: Color(0xffE010CD),
                      ),
                      Spacer(),
                      // SizedBox(width: 5),
                      UserProfileContainer(
                        icon: 'assets/icons/tindervectoricon.svg',
                        text: 'Subscription',
                        size: 10,
                        fontWeight: FontWeight.w500,
                        isThirdContainer: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 70, // adjust as needed
                    child: PageView(
                      controller: _pageController,
                      children: [
                        Center(
                            child: UserProfileBuilderPage(
                          subText: "Level up every action you take on Tinder",
                          iconPath: "assets/frames/tinderpdframe.svg",
                        )),
                        Center(
                            child: UserProfileBuilderPage(
                          subText: "See who Like You & more",
                          iconPath: "assets/frames/tindergdframe.svg",
                        )),
                        Center(
                          child: UserProfileBuilderPage(
                              iconPath: "assets/frames/tinderpldframe.svg",
                              // text: "Tinder Plus",
                              subText: "Get Unlimited Likes,Passport & More!"),
                        ),
                      ],
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: _currentPageIndex == index
                              ? 5.0
                              : 3.0, // modify this line
                          backgroundColor:
                              _currentPageIndex == index // modify this line
                                  ? Colors.white
                                  : Colors.grey,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 5),
                  if (_currentPageIndex == 0)
                    SubscriptionButton(
                      text: "Get Tinder Platinum",
                      color: Colors.black,
                    )
                  else if (_currentPageIndex == 1)
                    SubscriptionButton(
                      text: "Get Tinder Gold",
                      color: goldColor,
                    )
                  else if (_currentPageIndex == 2)
                    SubscriptionButton(
                      text: "Get Tinder Plus",
                      color: mainPinkColor,
                    ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
