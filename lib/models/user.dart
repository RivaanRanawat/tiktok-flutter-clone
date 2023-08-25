// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

class MyUser {
  String name;
  // String profilePhoto;
  String email;
  String id;

  MyUser({
    required this.name,
    required this.email,
    required this.id,
    // required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        // "profilePhoto": profilePhoto,
        "email": email,
        "id": id,
      };

  static MyUser fromSnap(snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MyUser(
      email: snapshot['email'],
      // profilePhoto: snapshot['profilePhoto'],
      id: snapshot['id'],
      name: snapshot['name'],
    );
  }
}
