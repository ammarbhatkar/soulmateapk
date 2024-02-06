// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LikeStarPage extends StatefulWidget {
  const LikeStarPage({Key? key}) : super(key: key);

  @override
  State<LikeStarPage> createState() => _LikeStarPageState();
}

class _LikeStarPageState extends State<LikeStarPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: SvgPicture.asset(
            "assets/icons/iconname.svg",
            // width: 92.708,
            height: 21.999,
            color: Color(
              0xffEA4080,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Color(0xffEA4080),
            dividerColor: Colors.white,
            tabs: [
              Tab(text: 'Likes'),
              Tab(text: 'Top Picks'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // First tab content - Likes
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/layouts/groupheart.svg",
                  ),
                  Center(
                    child: Text(
                      'Likes content goes here',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset(
                    "assets/layouts/logingoo.svg",
                  ),
                ],
              ),
            ),

            // Second tab content - Top Picks
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/layouts/groupheart.svg",
                  ),
                  Text(
                    'Top Picks content goes here',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset(
                    "assets/layouts/logingoo.svg",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
