// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soulmateapk/components/chat_bubble.dart';
import 'package:soulmateapk/components/my_textfield.dart';
import 'package:soulmateapk/pages/sent_image_view.dart';
import 'package:soulmateapk/pages/sent_video.dart';
import 'package:soulmateapk/services/auth_services.dart';
import 'package:soulmateapk/services/chats/chat_services.dart';
import 'package:soulmateapk/utils/custom_color.dart';
import 'package:soulmateapk/widgets/text_header.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ChatPage extends StatefulWidget {
  final String recieverName;
  final String receiverID;
  final String photoUrl;
  const ChatPage({
    super.key,
    required this.recieverName,
    required this.receiverID,
    required this.photoUrl,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatServices _chatServices = ChatServices();
  final AuthService _auth = AuthService();
  bool isSending = false;
  bool openAttachment = false;

// for textfiedl focus
  FocusNode _focusNode = FocusNode();
  // List<dynamic> _messages = [];
  // void _sendMessage({
  //   XFile? image,
  // }) {
  //   if (image != null || _controller.text.isNotEmpty) {
  //     setState(() {
  //       if (image != null) {
  //         _messages.add(image);
  //       } else if (_controller.text.isNotEmpty) {
  //         _messages.add(_controller.text);
  //       }
  //       _controller.clear();
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
// add a listener to focu node
    _focusNode.addListener(() {
      // cause a delay  so thata keyboard has time toshow up
      //then the amout of remaing space will be calculated
      // then scroll down
      if (_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });
    Future.delayed(Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

//scroll controlller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
    );
  }

// send message
  void sendMessage({File? imageFile, File? videoFile}) async {
    // If a video file is provided, send it as a message
    if (videoFile != null) {
      setState(() {
        isSending = true;
      });

      await _chatServices.sendMessage(
        widget.receiverID,
        videoFile: videoFile,
        isUploaded: true,
      );
      setState(() {
        isSending = false;
      });
    }
    // If an image file is provided, send it as a message
    else if (imageFile != null) {
      setState(() {
        isSending = true;
      });
      await _chatServices.sendMessage(
        widget.receiverID,
        imageFile: imageFile,
        isUploaded: true,
      );
      setState(() {
        isSending = false;
      });
    }
    // If there is something inside controller, send it as a text message
    else if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(
        widget.receiverID,
        message: _messageController.text,
        isUploaded: true,
      );
      _messageController.clear();
    }
    scrollDown();
  }

  Future<Uint8List> _generateThumbnail(String videoPath) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      maxWidth: 128,
      quality: 100,
    );
    return thumbnail!;
  }

  Widget _buildThumbnailWidget(String videoPath) {
    return FutureBuilder<Uint8List>(
      future: _generateThumbnail(videoPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              //width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: MemoryImage(snapshot.data!),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          ); // You can return a placeholder here while the thumbnail is being generated.
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Uint8List?> _generateThumbnail(String videoPath) async {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        maxWidth:
            512, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 100,
      );
      return uint8list;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back,
          color: subHeadingGrey,
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                widget.photoUrl,
                width: 34,
                height: 34,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 5),
            HeaderText(
              text: widget.recieverName,
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        actions: [
          // InkWell(
          //   onTap: () {},
          //   child: Icon(
          //     Icons.videocam,
          //     color: Color(0xff1786FF),
          //     size: 30,
          //   ),
          // ),
          // SizedBox(width: 16),
          SvgPicture.asset(
            "assets/icons/Vector.svg",
            height: 25,
            width: 15,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(
            child: _buildMessageList(),
          ),
          //user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    ImagePicker picker = ImagePicker();
    Future<void> pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        sendMessage(imageFile: imageFile);
      }
      setState(() {
        openAttachment = false;
      });
    }

    Future<void> pickVideo() async {
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        File videoFile = File(pickedFile.path);
        sendMessage(videoFile: videoFile);
      }
      setState(() {
        openAttachment = false;
      });
    }

    String senderID = _auth.getCurrentUser()!.uid;
    // print("senderID: $senderID");
    // print("receiverID from: ${widget.receiverID}");

    return StreamBuilder(
      stream: _chatServices.getMessages(senderID, widget.receiverID),
      builder: (context, snapshot) {
        // print('Snapshot Data: ${snapshot.data}');
        if (snapshot.data == null) {
          return Center(
            child: Text("No messages"),
          );
        }
        //error
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Loading...."),
          );
        }
        //listview
        // return ListView(
        //   children:
        //       snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        // );
        List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
        docs.sort((b, a) {
          var aData = a.data() as Map<String, dynamic>;
          var bData = b.data() as Map<String, dynamic>;
          if (aData != null && bData != null) {
            return bData['timeStamp'].compareTo(
                aData['timeStamp']); // sort the messages based on the timeStamp
          }
          return 0;
        });
        return Stack(
          children: [
            isSending
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    controller: _scrollController,
                    children:
                        docs.map((doc) => _buildMessageItem(doc)).toList(),
                  ),
            openAttachment
                ? Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 115, 112, 112)
                                .withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.image),
                            onPressed: () async {
                              await pickImage();
                              // Navigator.pop(context);
                              // Code to pick an image
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.video_library),
                            onPressed: () async {
                              await pickVideo();
                              // Navigator.pop(context);
                              // Code to pick a video
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        );
      },
    );
  }

  //build message Item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // print("the data in snapshot message is ${data["message"]}");
    // print the message in the console
    bool isCurrentUser = data["senderID"] == _auth.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    // return Container(
    //   alignment: alignment,
    //   child: ChatBubble(
    //     message: data["message"],
    //     isCurrentUser: isCurrentUser,
    //   ),
    // );
    return Container(
      alignment: alignment,
      child: data["videoUrl"] != null
          ? InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoApp(
                      path: data["videoUrl"],
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(4),
                margin:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                width: 170,
                height: 230,
                // width: 200,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 194, 221, 250),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _buildThumbnailWidget(data["videoUrl"]),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(115, 48, 47, 47),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ]),
              ),
            )
          : data["imageUrl"] != null
              ? InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SentImageView(
                          image: data["imageUrl"],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 194, 221, 250),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 220,
                      maxWidth: 220,
                    ),
                    margin:
                        EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                    padding: EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        data["imageUrl"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : ChatBubble(
                  message: data["message"],
                  isCurrentUser: isCurrentUser,
                ),
    );
  }

  //build message input
  Widget _buildUserInput() {
    // ImagePicker picker = ImagePicker();
    // Future<void> pickImage() async {
    //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    //   if (pickedFile != null) {
    //     File imageFile = File(pickedFile.path);
    //     sendMessage(imageFile: imageFile);
    //   }
    // }

    // Future<void> pickVideo() async {
    //   final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    //   if (pickedFile != null) {
    //     File videoFile = File(pickedFile.path);
    //     sendMessage(videoFile: videoFile);
    //   }
    // }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              focusNode: _focusNode,
              controller: _messageController,
              text: " Type a message . . .",
              obsecureText: false,
              suffixIcon: IconButton(
                icon: Icon(Icons.attachment),
                onPressed: () {
                  setState(() {
                    openAttachment = !openAttachment;
                  });
                  //   showModalBottomSheet(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(12),
                  //         topRight: Radius.circular(12),
                  //       ),
                  //     ),
                  //     context: context,
                  //     builder: (context) {
                  //       return Container(
                  //         padding: EdgeInsets.all(8.0),
                  //         decoration: BoxDecoration(
                  //             // color: Colors.yellow,
                  //             borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(12),
                  //           topRight: Radius.circular(12),
                  //         )),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           children: [
                  //             IconButton(
                  //               icon: Icon(Icons.image),
                  //               onPressed: () async {
                  //                 await pickImage();
                  //                 Navigator.pop(context);
                  //                 // Code to pick an image
                  //               },
                  //             ),
                  //             IconButton(
                  //               icon: Icon(Icons.video_library),
                  //               onPressed: () async {
                  //                 await pickVideo();
                  //                 Navigator.pop(context);
                  //                 // Code to pick a video
                  //               },
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[300],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(
                  onPressed: sendMessage,
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
