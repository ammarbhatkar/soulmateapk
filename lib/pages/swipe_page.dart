// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use, sort_child_properties_last

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:soulmateapk/button_pages/boost_page.dart';

import 'package:soulmateapk/pages/add_photos.dart';
import 'package:soulmateapk/pages/chat_page.dart';
import 'package:soulmateapk/pages/interest_category.dart';
import 'package:soulmateapk/pages/user_profile.dart';
import 'package:soulmateapk/routes/scale_route.dart';
import 'package:soulmateapk/services/auth_services.dart';
import 'package:soulmateapk/services/chats/chat_services.dart';
import 'package:soulmateapk/utils/custom_color.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SwipePage extends StatefulWidget {
  List<XFile?>? selectedImages = [];
  SwipePage({
    super.key,
    this.selectedImages,
  });

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();
  PageController _pageController = PageController();
  final ChatServices _chatServices = ChatServices();
  CardSwiperController _cardSwiperController = CardSwiperController();
  int currentPageIndex = 0;
  var currentImageIndex = 0.obs;

  void onTap(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  double calculateIndicatorWidth(int numberOfImages) {
    // Adjust the constant value based on your design preferences
    const double defaultIndicatorWidth = 10.0;

    return MediaQuery.of(context).size.width / numberOfImages - 2;
  }

  List<Person> people = [
    Person(
      image: "assets/images/ammar1.jpeg",
      age: 25,
      distance: 1.5,
      name: "king",
    ),
    Person(
      image: "assets/images/ammar2.jpeg",
      age: 30,
      distance: 2,
      name: "Ammar",
    ),
    Person(
      image: "assets/images/ammar3.jpeg",
      age: 23,
      distance: 3,
      name: "Flutter",
    ),

    Person(
      image: "assets/images/rohan.jpg",
      age: 25,
      distance: 3,
      name: "Rohan",
    ),

    Person(
      image: "assets/images/moin.png",
      age: 25,
      distance: 3,
      name: "Rohan",
    ),
    // Add more people here...
  ];
  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    currentImageIndex.value = 0;
    return true;
  }

  @override
  void initState() {
    // _auth.getCurrentUser()!.uid;
    print("this is the current user id ${_auth.getCurrentUser()!.uid}");
    print("this is the selected images ${widget.selectedImages}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              "assets/icons/iconname.svg",
              width: 92.708,
              height: 21.999,
              color: Color(
                0xffEA4080,
              ),
            ),
            Row(
              children: [
                Image.asset(
                  "assets/icons/filter.png",
                  color: Color(0xff7D848F),
                  width: 30,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.black,
        child: StreamBuilder(
          stream: _chatServices.getUserStream(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            //errror
            if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            }
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: mainPinkColor,
                ),
              );
            }
            //loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: mainPinkColor,
                ),
              );
            }
            List<Map<String, dynamic>> users = List.from(snapshot.data!);
            users.removeWhere(
                (user) => user["uid"] == _auth.getCurrentUser()!.uid);

            return Container(
              // color: Colors.black,
              color: Colors.black,
              // color: const Color.fromARGB(255, 232, 17, 17),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: CardSwiper(
                      controller: _cardSwiperController,
                      onSwipe: _onSwipe,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      scale: 0,
                      // cardsCount: people.length,
                      cardsCount: snapshot.data!.length -
                          1, // Set the cardsCount to the number of users

                      cardBuilder: (context, index, percentThresholdX,
                          percentThresholdY) {
                        return Stack(children: [
                          GestureDetector(
                            onTap: () {
                              if (currentImageIndex.value <
                                  users[index]["images"].length - 1) {
                                print(
                                    "image index is ${currentImageIndex.value}");
                                print(
                                    "image length is ${users[index]["images"].length}");
                                currentImageIndex.value++;
                              } else {
                                currentImageIndex.value = 0;
                              }
                            },
                            child: Container(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height * 0.62,
                              // color: Colors.red,
                              // color: Colors.blue, // You might want to change this
                              child: Obx(
                                () =>
                                    // child:
                                    ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: Image.network(
                                    users[index]["images"][currentImageIndex
                                        .value], // Assuming images is a list in your data
                                    fit: BoxFit.fill,
                                  ),
                                  // child: Image.asset(
                                  //   people[index].image,
                                  //   fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          // ),
                          // Positioned(
                          //   top: 4,
                          //   left: 2,
                          //   right: 2,
                          //   child: SmoothPageIndicator(
                          //     controller: _pageController,
                          //     count: users[index]["images"].length,
                          //     axisDirection: Axis.horizontal,
                          //     effect: SlideEffect(
                          //       spacing: 1,
                          //       radius: 2.0,
                          //       dotWidth: calculateIndicatorWidth(
                          //           users[index]["images"].length),
                          //       dotHeight: 2.5,
                          //       paintStyle: PaintingStyle.fill,
                          //       strokeWidth: 1.5,
                          //       dotColor: Colors.grey,
                          //       activeDotColor:
                          //           Color.fromARGB(255, 253, 253, 254),
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                            top: 4,
                            child: Obx(
                              () => PageViewDotIndicator(
                                currentItem: currentImageIndex.value,

                                count: users[index]["images"].length,
                                unselectedColor: Colors.grey,
                                selectedColor:
                                    const Color.fromARGB(255, 235, 236, 237),
                                size: Size(
                                    calculateIndicatorWidth(
                                            users[index]["images"].length) -
                                        2,
                                    4),
                                unselectedSize: Size(
                                    calculateIndicatorWidth(
                                            users[index]["images"].length) -
                                        2,
                                    4),
                                // duration: const Duration(milliseconds: 200),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                                fadeEdges: false,
                                boxShape:
                                    BoxShape.rectangle, //defaults to circle
                                borderRadius: BorderRadius.circular(
                                    5), //only for rectangle shape
                                // onItemClicked: (index) { ... }
                              ),
                            ),
                          ),
                          // Obx(
                          //   () => StepProgressIndicator(
                          //     totalSteps: users[index]["images"].length,
                          //     currentStep: currentImageIndex.value + 1,
                          //     selectedColor: Colors.white,
                          //     unselectedColor: Colors.grey,
                          //   ),
                          // ),

                          Positioned(
                            bottom: 0, // Adjust this value as needed
                            left: 0,
                            right: 0,

                            child: Container(
                              // color: Colors.amber,f
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: FractionalOffset.topCenter,
                                    end: FractionalOffset.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 53, 53, 53)
                                          .withOpacity(0.0),
                                      Colors.black.withOpacity(0.5),
                                      Colors.black,
                                      // Colors.white,
                                    ],
                                    stops: [
                                      0.0,
                                      0.2,
                                      0.5
                                    ]),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          // people[3].name,
                                          // snapshot.data![0]["name"],

                                          users[index]["firstname"],
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          // snapshot.data![0]["age"].toString(),

                                          users[index]["age"],
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.arrow_circle_up_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/location_indicator.svg",
                                          height: 20,
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          " Lives in Mumbai",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            // color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/location_indicator.svg",
                                          height: 20,
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          " 3 mile away",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            // color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]);
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    // bottom: MediaQuery.of(context).size.height * 0.035,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/Back.svg",
                          // width: 48.369,
                          // height: 48.369,
                          width: MediaQuery.sizeOf(context).width * 0.15,
                          height: MediaQuery.sizeOf(context).width * 0.15,
                          // color: currentPageIndex == 0
                          // // ? Color(0xffEA4080)
                          // // : Color(0xff7D848F),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("dislike tapeed");
                            _cardSwiperController.swipeLeft();
                          },
                          child: SvgPicture.asset(
                            "assets/icons/X.svg",
                            // width: 58.462,
                            // height: 58.462,
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            height: MediaQuery.sizeOf(context).width * 0.2,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("super like taped");
                            _cardSwiperController.swipeTop();
                          },
                          child: SvgPicture.asset(
                            "assets/icons/likestar.svg",
                            // width: 48.369,
                            // height: 48.369,

                            width: MediaQuery.sizeOf(context).width * 0.15,
                            height: MediaQuery.sizeOf(context).width * 0.15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("like tapeed");
                            _cardSwiperController.swipeRight();
                          },
                          child: SvgPicture.asset(
                            "assets/icons/likebutton.svg",
                            // width: 64.462,
                            // height: 64.462,

                            width: MediaQuery.sizeOf(context).width * 0.23,
                            height: MediaQuery.sizeOf(context).width * 0.23,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context, ScaleRoute(page: BoostPage()));
                          },
                          child: SvgPicture.asset(
                            "assets/icons/Boost.svg",
                            // width: 48.369,
                            // height: 48.369,

                            width: MediaQuery.sizeOf(context).width * 0.15,
                            height: MediaQuery.sizeOf(context).width * 0.15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Person {
  final String image;
  final int age;
  final double distance;
  final String name;

  Person({
    required this.image,
    required this.age,
    required this.distance,
    required this.name,
  });
}
