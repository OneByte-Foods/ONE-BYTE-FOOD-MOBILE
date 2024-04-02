import 'package:One_Bytes_Food/constants/app_style.dart';
import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/constants/user_constants.dart';
import 'package:One_Bytes_Food/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).updateLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
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

PreferredSizeWidget buildAppBar() {
  return AppBar(
    leading: Image.asset(
      "assets/icons/drawer_icon.png",
      width: 20,
    ),
    backgroundColor: AppColors.scaffoldBackgroundColor,
    title: Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 60),
                Image.asset(
                  "assets/icons/location_icon.png",
                  width: 20,
                ),
                SizedBox(width: 5),
                Text(
                  locationProvider.currentLocation,
                  style: AppStyles.text12PxRegular,
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                UserConstants.userImageUrl ??
                    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpngtree.com%2Fso%2Fcolor-avatar&psig=AOvVaw3LBqsd-Zyur4YjI7mf7MyE&ust=1712128009079000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKjrmYH8ooUDFQAAAAAdAAAAABAJ",
              ),
              radius: 15,
            ),
          ],
        );
      },
    ),
  );
}
