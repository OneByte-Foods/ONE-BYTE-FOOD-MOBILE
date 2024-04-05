import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  static Future addUser(String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("Google_Account_Users")
        .doc(userId)
        .set(userInfoMap);
  }

  static Future randomSiginUsers(
    UserCredential userCredential,
    String username,
    String email,
  ) async {
    return await FirebaseFirestore.instance
        .collection('Random_Signin_Users')
        .doc(userCredential.user?.uid)
        .set({
      'username': username,
      'email': email,
    });
  }

  static Future<String?> getUsername(String userId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Random_Signin_Users')
        .doc(userId)
        .get();

    if (snapshot.exists) {
      return snapshot.get('username');
    } else {
      return null;
    }
  }
}
