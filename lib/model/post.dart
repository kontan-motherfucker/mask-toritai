import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String maskRequirement;
  String visitDate;
  String username;
  String prefecture;
  String facility;
  String detail;
  Timestamp createdDate;
  Timestamp? updatedDate;

  Post({
    required this.id,
    required this.maskRequirement,
    required this.visitDate,
    required this.username,
    required this.prefecture,
    required this.facility,
    required this.detail,
    required this.createdDate,
    this.updatedDate
  });
}