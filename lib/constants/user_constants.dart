import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_information_model.dart';

class UserConstants {
  static final userImageUrl = FirebaseAuth.instance.currentUser != null
      ? UserInformation.fromUser(FirebaseAuth.instance.currentUser!).imgUrl
      : null;
  static final userNameUrl = FirebaseAuth.instance.currentUser != null
      ? UserInformation.fromUser(FirebaseAuth.instance.currentUser!).username
      : null;
}
