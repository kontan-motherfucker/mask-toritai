import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String name;
  String content;
  Timestamp commentDate;

  Comment({
    required this.name,
    required this.content,
    required this.commentDate,
  });
}