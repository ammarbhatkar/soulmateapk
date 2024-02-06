import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soulmateapk/models/message_model.dart';

class ChatServices {
  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  //get user strea
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<List<String>> uploadUserImages(List<XFile?> imageFiles) async {
    final String currentUserID = _auth.currentUser!.uid;
    List<String> imageUrls = [];

    for (var imageFile in imageFiles) {
      var storageRef = _storage
          .ref()
          .child('user_images')
          .child(currentUserID) // add this line
          .child(Timestamp.now().millisecondsSinceEpoch.toString());

      await storageRef.putFile(File(imageFile!.path));
      String imageUrl = await storageRef.getDownloadURL();

      imageUrls.add(imageUrl);
    }

    // Update the Firestore document with the image URLs
    await _firestore.collection('Users').doc(currentUserID).update({
      'images': FieldValue.arrayUnion(imageUrls),
    });

    return imageUrls;
  }

  Future<void> sendMessage(String receiverID,
      {String? message,
      File? imageFile,
      File? videoFile,
      bool? isUploaded}) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // sort the ids (this to ensure the chatroom id is te same for any two people)
    String chatRoomID = ids.join('_');

    // if user is sending image then upload teh mage to firebase storage
    // and store teh url of image in chatrooms message
    String? imageUrl;
    if (imageFile != null) {
      var storageRef = _storage
          .ref()
          .child('chat_images')
          .child(Timestamp.now().millisecondsSinceEpoch.toString());
      await storageRef.putFile(imageFile);
      imageUrl = await storageRef.getDownloadURL();
    }

    String? videoUrl;
    if (videoFile != null) {
      var storageRef = _storage
          .ref()
          .child('chat_videos')
          .child(Timestamp.now().millisecondsSinceEpoch.toString());
      await storageRef.putFile(videoFile);
      videoUrl = await storageRef.getDownloadURL();
    }
    //create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      imageUrl: imageUrl,
      timeStamp: timestamp,
      isUploaded: isUploaded ?? false,
      videoUrl: videoUrl,
    );
    // now we need to construct a chat room id to store al this messages
    // construct chat room for teh two users (sorted to ensure uniqueness)

    //add message to db,

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get messages

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //constrcut chat room id for two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        // .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
