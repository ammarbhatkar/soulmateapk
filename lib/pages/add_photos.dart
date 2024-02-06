// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soulmateapk/pages/image_capture_options.dart';
import 'package:soulmateapk/pages/main_page.dart';
import 'package:soulmateapk/pages/swipe_page.dart';
import 'package:soulmateapk/pages/user_profile.dart';
import 'package:soulmateapk/services/auth_services.dart';
import 'package:soulmateapk/services/chats/chat_services.dart';
import 'package:soulmateapk/widgets/heading1_text.dart';
import 'package:soulmateapk/widgets/normal_button.dart';
import 'package:soulmateapk/widgets/photos_container.dart';
import 'package:soulmateapk/widgets/text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AddCustomPhotos extends StatefulWidget {
  final String? firstname;
  final String? birthDate;
  final String? gender;
  const AddCustomPhotos(
      {super.key, this.firstname, this.birthDate, this.gender});

  @override
  State<AddCustomPhotos> createState() => _AddCustomPhotosState();
}

class _AddCustomPhotosState extends State<AddCustomPhotos> {
  final ChatServices _chatServices = ChatServices();
  bool isLoading = false;
  // instanece of authservice
  final AuthService _auth = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    print("firstname: ${widget.firstname}");
    print("birthDate: ${widget.birthDate}");
    print("gender is ${widget.gender}");
  }

  Future<void> updateProfileStatus() async {
    try {
      //get current user
      await _auth.getCurrentUser();
      //update sttsus of user
      await _firestore
          .collection("Users")
          .doc(_auth.getCurrentUser()!.uid)
          .update({
        "profileSetup": true,
      });
    } catch (e) {
      print("Error upating profile status:e");
    }
  }

  List<XFile?> selectedImages = List.generate(6, (_) => null);
  int get numberOfSelectedImages =>
      selectedImages.where((image) => image != null).length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepProgressIndicator(
                totalSteps: 100,
                currentStep: 100,
                size: 6,
                padding: 0,
                selectedColor: Colors.yellow,
                unselectedColor: Colors.grey,
                roundedEdges: Radius.circular(10),
                selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xfffd267a),
                    Color(0xffff6036),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Icon(
                  Icons.arrow_back,
                  color: Color.fromRGBO(130, 134, 147, 1),
                  size: 30,
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: HeaderText(
                  text: "Add your recent pics ",
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 30),
              GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.7
                    // Adjust this value to change the height of the tiles
                    ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      print("this is index $index");
                      final selectedImage = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomImageCaptureOptions(),
                        ),
                      );
                      setState(() {
                        // Update the selected image in the list
                        selectedImages[index] = selectedImage;
                      });
                    },
                    child: PhotosContainer(
                      imagePath: selectedImages[index]?.path,
                      iconPath: selectedImages[index] == null
                          ? "assets/icons/photoaddicon.svg"
                          : "assets/icons/removephotoicon.svg",
                      onRemove: () {
                        setState(() {
                          selectedImages[index] = null;
                          // selectedImages.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Container(
              //       child: PhotosContainer(
              //         iconPath: "assets/icons/removephotoicon.svg",
              //         imagePath: "assets/images/ammar1.jpeg",
              //       ),
              //     ),
              //     PhotosContainer(),
              //     PhotosContainer(),
              //   ],
              // ),
              // SizedBox(height: 14),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     PhotosContainer(),
              //     PhotosContainer(),
              //     PhotosContainer(),
              //   ],
              // ),
              // SizedBox(height: 80),
              // SizedBox(height: 80),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // color: Colors.amber,
                    height: 80, // adjust as needed
                    width: 80, // adjust as needed
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            interval: 10,
                            startAngle: 180,
                            endAngle: 180,
                            showTicks: false,
                            showLabels: false,
                            axisLineStyle: AxisLineStyle(thickness: 5),
                            pointers: <GaugePointer>[
                              RangePointer(
                                // value: 10,
                                value: numberOfSelectedImages.toDouble() *
                                    (100 / 6), // update this line

                                width: 5,
                                gradient: const SweepGradient(
                                  colors: <Color>[
                                    Color(0xfffd267a),
                                    Color(0xffff6036),
                                  ],
                                ),
                                // color: Color(0xFFFFCD60),
                                enableAnimation: true,
                                cornerStyle: CornerStyle.bothFlat,
                              ),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget: Container(
                                    child: Text(
                                      // '1 / 6',
                                      '${numberOfSelectedImages} / 6', // update this line

                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  angle: 90,
                                  positionFactor: 0.1)
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Hey! lets add 2 to start. We \nrecommend for a face pic",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(130, 134, 147, 1),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              // SizedBox(height: 40),
              SizedBox(height: 20),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color(0xfffd267a),
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () async {
                    if (numberOfSelectedImages >= 2) {
                      setState(() {
                        isLoading = true;
                      });
                      await _chatServices.uploadUserImages(
                        selectedImages.where((image) => image != null).toList(),
                      );
                      await updateProfileStatus();
                      setState(() {
                        isLoading = false;
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(
                            // selectedImages: selectedImages,
                            selectedImages: selectedImages,
                            // selectedImages.whereType<XFile>().toList(),
                          ),
                        ),
                      );
                    }
                  },
                  child: NormalButton(
                    text: "Next",
                    gradient: numberOfSelectedImages >= 2
                        ? LinearGradient(
                            colors: [
                              Color(0xfffd267a),
                              Color(0xffff6036),
                            ],
                          )
                        : null,
                    color: numberOfSelectedImages >= 2
                        ? Colors.white
                        : Color.fromRGBO(130, 134, 147, 1),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
