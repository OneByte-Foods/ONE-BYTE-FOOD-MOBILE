import 'package:firebase_auth/firebase_auth.dart';

class UserInformation {
  final String email;
  final String username;
  final String? imgUrl; // Making imgUrl nullable in case it's not provided
  final String id;

  UserInformation({
    required this.email,
    required this.username,
    this.imgUrl,
    required this.id,
  });

  factory UserInformation.fromUser(User user) {
    return UserInformation(
      email:
          user.email ?? '', // Using empty string as fallback if email is null
      username: user.displayName ??
          '', // Using empty string as fallback if displayName is null
      imgUrl: user.photoURL,
      id: user.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'imgUrl': imgUrl,
      'id': id,
    };
  }
}
