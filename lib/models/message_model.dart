import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String? message;
  final String? imageUrl;
  final String? videoUrl;
  final Timestamp timeStamp;
  final bool isUploaded;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    this.message,
    this.imageUrl,
    this.videoUrl,
    required this.timeStamp,
    required this.isUploaded,
  });
  //convert it to map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': receiverID,
      'receiverID': receiverID,
      'message': message,
      'imageUrl': imageUrl,
      'timeStamp': timeStamp,
      'videoUrl': videoUrl,
      'isUploaded': isUploaded,
    };
  }
}
