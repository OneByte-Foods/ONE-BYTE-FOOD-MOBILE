import 'package:One_Bytes_Food/constants/app_style.dart';
import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/constants/user_constants.dart';
import 'package:One_Bytes_Food/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/search_bar_widget.dart';

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
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ModernSearchBar(),
              ],
            ),
          ],
        ));
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
        print("Location -> " + locationProvider.currentLocation);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 30),
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
                    "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745",
              ),
              radius: 15,
            ),
          ],
        );
      },
    ),
  );
}
