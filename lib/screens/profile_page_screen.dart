import 'package:One_Bytes_Food/constants/app_style.dart';
import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/constants/user_constants.dart';
import 'package:One_Bytes_Food/widgets/build_btn.dart';
import 'package:One_Bytes_Food/widgets/circle_avatar_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCircleAvatar(radius: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<String?>(
                        future: UserConstants.getUsername,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            String? username = snapshot.data;
                            return Text(
                              username ?? UserConstants.userNameUrl!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }
                        },
                      ),
                      Text(UserConstants.userEmail!),
                    ],
                  ),
                  Image.asset(
                    "assets/icons/notification.png",
                  ),
                ],
              ),
            ),
          ),
          _buildCard(
            context: context,
            title: "Account Settings",
            firstIcon: "assets/icons/profile_icon.png",
            secondIcon: "assets/icons/edit_icon.png",
          ),
          SizedBox(
            height: 20,
          ),
          _buildCard(
            context: context,
            title: "Language",
            firstIcon: "assets/icons/language_icon.png",
            secondIcon: "assets/icons/arrow_icon.png",
            width: 180,
          ),
          _buildCard(
            context: context,
            title: "Feedback",
            firstIcon: "assets/icons/feedback_icon.png",
            secondIcon: "assets/icons/arrow_icon.png",
            width: 180,
            xyz: false,
          ),
          _buildCard(
            context: context,
            title: "Rate us",
            firstIcon: "assets/icons/rate_icon.png",
            secondIcon: "assets/icons/arrow_icon.png",
            width: 200,
            xyz: false,
          ),
          _buildCard(
            xyz: false,
            context: context,
            title: "New version",
            firstIcon: "assets/icons/version_icon.png",
            secondIcon: "assets/icons/arrow_icon.png",
            width: 160,
          ),
          SizedBox(height: 30),
          buildButton(
            context,
            width: 100,
            text: "Logout",
            color: Colors.red,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Logout"),
                    content: Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform logout action here
                          Navigator.of(context).pop();
                        },
                        child: Text("Logout"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildCard({
  required BuildContext context,
  required String title,
  required String firstIcon,
  required String secondIcon,
  double? width,
  bool xyz = true,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    height: 50,
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: xyz ? BorderRadius.circular(11) : null,
    ),
    child: Row(
      children: [
        Image.asset(firstIcon),
        SizedBox(width: 20),
        Text(
          title,
          style: AppStyles.text18PxRegular,
        ),
        SizedBox(width: width ?? 120),
        Image.asset(secondIcon),
      ],
    ),
  );
}
