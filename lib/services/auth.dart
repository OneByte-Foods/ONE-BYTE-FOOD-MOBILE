import 'package:One_Bytes_Food/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_information_model.dart';
import '../routes/app_routes.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
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
          final userInformation = UserInformation.fromUser(userDetails);

          await DatabaseMethods.addUser(
              userDetails.uid, userInformation.toMap());
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
