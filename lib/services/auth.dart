import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_mobile_app/routes/app_routes.dart';
import 'package:new_mobile_app/services/database.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> signInWithGoogle(context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        final UserCredential result =
            await _auth.signInWithCredential(credential);
        final User? userDetails = result.user;

        if (userDetails != null) {
          final userInfoMap = {
            "email": userDetails.email,
            "username": userDetails.displayName,
            "imgUrl": userDetails.photoURL,
            "id": userDetails.uid,
          };

          await DatabaseMethods.addUser(userDetails.uid, userInfoMap);
          Navigator.pushNamed(context, AppRoutes.homePageScreen);
          return;
        }
      }
      throw FirebaseAuthException(
          message: 'Sign in with Google failed', code: '');
    } catch (e) {
      print('Error signing in with Google: $e');
      throw e;
    }
  }
}
