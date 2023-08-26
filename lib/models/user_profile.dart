// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileUser {
  String username;
  String avatarUrl;
  String? email;
  String id;

  ProfileUser({
    required this.username,
    required this.email,
    required this.id,
    required this.avatarUrl,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "avatarUrl": avatarUrl,
        "email": email,
        "id": id,
      };

// TODO: Fix this
  static ProfileUser fromSnap(snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ProfileUser(
      email: snapshot['email'],
      avatarUrl: snapshot['avatarUrl'],
      id: snapshot['id'],
      username: snapshot['username'],
    );
  }
}
