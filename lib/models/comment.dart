// import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  final DateTime datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;

  Comment({
    required this.username,
    required this.comment,
    required this.datePublished,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.id,
  });

  // Map<String, dynamic> toJson() => {
  //       'username': username,
  //       'comment': comment,
  //       'datePublished': datePublished,
  //       'likes': likes,
  //       'profilePhoto': profilePhoto,
  //       'uid': uid,
  //       'id': id,
  //     };

  factory Comment.fromMap({required Map<String, dynamic> map}) {
    return Comment(
      username: map['username'],
      comment: map['comment'],
      datePublished: map['datePublished'],
      likes: map['likes'],
      profilePhoto: map['profilePhoto'],
      uid: map['uid'],
      id: map['id'],
    );
  }
}
