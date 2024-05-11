import 'package:One_Bytes_Food/constants/global_colors.dart';
import 'package:One_Bytes_Food/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../widgets/round_button.dart';

class CheckoutMessageView extends StatefulWidget {
  const CheckoutMessageView({super.key});

  @override
  State<CheckoutMessageView> createState() => _CheckoutMessageViewState();
}

class _CheckoutMessageViewState extends State<CheckoutMessageView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      width: media.width,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: AppColors.primaryText,
                  size: 25,
                ),
              )
            ],
          ),
          Image.asset(
            "assets/img/thank_you.png",
            width: media.width * 0.55,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            "Thank You!",
            style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 26,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "for your order",
            style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 17,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            "Your Order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your Order",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.primaryText, fontSize: 14),
          ),
          const SizedBox(
            height: 35,
          ),
          RoundButton(
              title: "Track My Order",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.googleMapScreen);
              }),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.homePageScreen);
            },
            child: Text(
              "Back To Home",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
