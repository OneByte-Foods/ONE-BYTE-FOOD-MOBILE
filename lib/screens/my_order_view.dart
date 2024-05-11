import 'package:One_Bytes_Food/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/global_colors.dart';
import '../provider/cart_provider.dart';
import '../widgets/round_button.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({super.key});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  List itemArr = [
    {"name": "Beef Burger", "qty": "1", "price": 16.0},
    {"name": "Classic Burger", "qty": "1", "price": 14.0},
    {"name": "Cheese Chicken Burger", "qty": "1", "price": 17.0},
    {"name": "Chicken Legs Basket", "qty": "1", "price": 15.0},
    {"name": "French Fires Large", "qty": "1", "price": 6.0}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset("assets/img/btn_back.png",
                          width: 20, height: 20),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        "My Order",
                        style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/img/shop_logo.png",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "King Burgers",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/img/rate.png",
                                width: 10,
                                height: 10,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "4.9",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.primary, fontSize: 12),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "(124 Ratings)",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Burger",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 12),
                              ),
                              Text(
                                " . ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.primary, fontSize: 12),
                              ),
                              Text(
                                "Western Food",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/img/location-pin.png",
                                width: 13,
                                height: 13,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  "No 03, 4th Lane, Newyork",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: AppColors.secondaryText,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(color: AppColors.textfield),
                child: Consumer<CartModel>(
                  builder: (context, cart, child) {
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: cart.items.length,
                      separatorBuilder: ((context, index) => Divider(
                            indent: 25,
                            endIndent: 25,
                            color: AppColors.secondaryText.withOpacity(0.5),
                            height: 1,
                          )),
                      itemBuilder: ((context, index) {
                        var cObj = cart.items[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "${cObj["name"].toString()} x${cObj["qty"].toString()}",
                                  style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "\$${cObj["price"].toString()}",
                                style: TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      color: AppColors.secondaryText.withOpacity(0.5),
                      height: 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sub Total",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                        Consumer<CartModel>(
                          builder: (context, cart, child) {
                            return Text(
                              "\$" +
                                  cart
                                      .calculateSubTotal(cart.items)
                                      .toStringAsFixed(2),
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Cost",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "\$2",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Divider(
                      color: AppColors.secondaryText.withOpacity(0.5),
                      height: 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                        Consumer<CartModel>(
                          builder: (context, cart, child) {
                            return Text(
                              "\$" +
                                  cart
                                      .calculateTotal(cart.items)
                                      .toStringAsFixed(2),
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    RoundButton(
                        title: "Checkout",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckoutView(),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
