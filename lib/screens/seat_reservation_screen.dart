import 'package:One_Bytes_Food/widgets/table_booking_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../constants/global_colors.dart';
import '../model/arm_chair_model.dart';
import '../widgets/build_btn.dart';
import '../widgets/seat_row.dart';
import '../widgets/textFrave.dart';

class SeatReservationScreen extends StatelessWidget {
  const SeatReservationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: AppColors.lightYellow,
          ),
          Container(
            height: size.height * .7,
            width: size.width,
            child: Container(
              child: ClipRRect(
                child: Container(),
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  SizedBox(height: 55.0),
                  Container(
                    height: 240,
                    width: size.width,
                    child: Column(
                      children: List.generate(
                        ArmChairsModel.listChairs.length,
                        (i) => SeatsRow(
                          numSeats: ArmChairsModel.listChairs[i].seats,
                          freeSeats: ArmChairsModel.listChairs[i].freeSeats,
                          rowSeats: ArmChairsModel.listChairs[i].rowSeats,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 55.0),
                  _ItemsDescription(size: size)
                ],
              ),
            ),
          ),
          Positioned(
            left: 60,
            right: 60,
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildButton(context,
                  text: "Reserve your table ${2.0}",
                  color: AppColors.green, onPressed: () {
                table_booking_bottom_sheet(context);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemsDescription extends StatelessWidget {
  const _ItemsDescription({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Icon(Icons.circle, color: Colors.white, size: 10),
              SizedBox(width: 10.0),
              TextFrave(text: 'Free', fontSize: 20, color: Colors.white)
            ],
          ),
          Row(
            children: [
              Icon(Icons.circle, color: Color(0xff4A5660), size: 10),
              SizedBox(width: 10.0),
              TextFrave(
                  text: 'Reserved', fontSize: 20, color: Color(0xff4A5660))
            ],
          ),
          Row(
            children: [
              Icon(Icons.circle, color: Colors.amber, size: 10),
              SizedBox(width: 10.0),
              TextFrave(text: 'Selected', fontSize: 20, color: Colors.amber)
            ],
          ),
        ],
      ),
    );
  }
}
