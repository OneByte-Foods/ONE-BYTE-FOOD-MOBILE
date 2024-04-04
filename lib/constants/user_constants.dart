import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_information_model.dart';

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
}
