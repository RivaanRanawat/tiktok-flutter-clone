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

  // Map<String, dynamic> toJson() => {
  //       "username": username,
  //       "avatarUrl": avatarUrl,
  //       "email": email,
  //       "id": id,
  //     };

  factory ProfileUser.fromMap({required Map<String, dynamic> map}) {
    return ProfileUser(
      email: map['email'],
      avatarUrl: map['avatarUrl'],
      id: map['id'],
      username: map['username'],
    );
  }
}
