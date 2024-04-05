import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_information_model.dart';
import '../services/database.dart';

class UserConstants {
  // firebase
  static final userImageUrl = FirebaseAuth.instance.currentUser != null
      ? UserInformation.fromUser(FirebaseAuth.instance.currentUser!).imgUrl
      : null;
  static final userNameUrl = FirebaseAuth.instance.currentUser != null
      ? UserInformation.fromUser(FirebaseAuth.instance.currentUser!).username
      : null;
  static final userEmail = FirebaseAuth.instance.currentUser != null
      ? UserInformation.fromUser(FirebaseAuth.instance.currentUser!).email
      : null;
  static Future<String?> getUsername = FirebaseAuth.instance.currentUser != null
      ? DatabaseMethods.getUsername(FirebaseAuth.instance.currentUser!.uid)
      : Future.value(null);
}
