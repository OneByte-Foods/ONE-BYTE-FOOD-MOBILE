import 'package:One_Bytes_Food/screens/login_page.dart';
import 'package:One_Bytes_Food/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future modalBottomSheet(BuildContext context, TabController _tabController) {
  return showMaterialModalBottomSheet(
    expand: false,
    elevation: 0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(36),
      topRight: Radius.circular(36),
    )),
    context: context,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.7,
        child: Column(
          children: [
            TabBar(
              isScrollable: false,
              dividerColor: Colors.transparent,
              controller: _tabController,
              tabs: [
                Tab(
                  text: 'Sign Up',
                ),
                Tab(
                  text: 'Login',
                )
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              // height: MediaQuery.of(context).size.height * 0.1,
              child: TabBarView(controller: _tabController, children: [
                SignupScreen(),
                LoginPageScreen(),
              ]),
            )
          ],
        ),
      );
    },
  );
}
