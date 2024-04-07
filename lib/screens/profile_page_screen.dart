import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/constants/user_constants.dart';
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
