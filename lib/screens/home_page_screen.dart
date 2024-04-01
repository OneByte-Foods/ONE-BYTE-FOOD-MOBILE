import 'package:One_Bytes_Food/constants/app_style.dart';
import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/constants/user_constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Agrabad 435, Chittagong"),
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Center(
        child: Text(
          "Home Page",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget buildAppBar(String location) {
  return AppBar(
    leading: Image.asset("assets/icons/drawer_icon.png"),
    backgroundColor: AppColors.scaffoldBackgroundColor,
    title: Row(
      children: [
        SizedBox(
          width: 5,
        ),
        Image.asset(
          "assets/icons/location_icon.png",
          width: 20,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          location,
          style: AppStyles.text12PxRegular,
        ),
        SizedBox(
          width: 70,
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(
            UserConstants.userImageUrl ?? "https://via.placeholder.com/150",
          ),
          radius: 15,
        ),
      ],
    ),
  );
}
