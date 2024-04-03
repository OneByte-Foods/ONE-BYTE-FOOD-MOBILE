import 'package:flutter/material.dart';

import '../constants/user_constants.dart';

Widget buildCircleAvatar({required double radius}) {
  return CircleAvatar(
    backgroundImage: NetworkImage(
      UserConstants.userImageUrl ??
          "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745",
    ),
    radius: radius,
  );
}
