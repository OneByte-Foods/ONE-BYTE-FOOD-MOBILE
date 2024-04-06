import 'package:flutter/material.dart';

import '../constants/app_style.dart';
import '../constants/global_colors.dart';
import '../model/arm_chair_model.dart';
import '../widgets/seats_widget.dart';
import '../widgets/textFrave.dart';

class SeatReservationScreen extends StatefulWidget {
  const SeatReservationScreen({Key? key}) : super(key: key);

  @override
  State<SeatReservationScreen> createState() => _SeatReservationScreenState();
}

class _SeatReservationScreenState extends State<SeatReservationScreen> {
  late Stream<List<ArmChairsModel>> _armChairsStream;

  @override
  void initState() {
    super.initState();
    _armChairsStream = fetchArmChairsData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width * .9,
            height: size.height * .75,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppColors.green,
                borderRadius: BorderRadius.circular(25.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                // Avaible seats and other information
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Text(" 4 seats available",
                          style: AppStyles.text16PxRegular.copyWith(
                            color: Colors.white,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Text("27 person",
                          style: AppStyles.text16PxRegular.copyWith(
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                // first row
                Row(
                  children: [
                    SizedBox(width: 20),
                    TableWidget(
                      index: 1,
                      circleRadius: 13,
                      numSeats: 6.0,
                    ),
                    SizedBox(width: 20),
                    TableWidget(
                      index: 2,
                      circleRadius: 13,
                      numSeats: 2.0,
                    ),
                    SizedBox(width: 20),
                    TableWidget(
                      index: 3,
                      circleRadius: 13,
                      numSeats: 2.0,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // second row
                Row(
                  children: [
                    SizedBox(width: 20),
                    TableWidget(
                      index: 1,
                      circleRadius: 13,
                      numSeats: 4.0,
                    ),
                    SizedBox(width: 20),
                    TableWidget(
                      index: 2,
                      circleRadius: 13,
                      numSeats: 4.0,
                    ),
                    SizedBox(width: 20),
                    TableWidget(
                      index: 3,
                      circleRadius: 13,
                      numSeats: 2.0,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // third row
                Row(
                  children: [
                    SizedBox(width: 20),
                    TableWidget(
                      index: 4,
                      circleRadius: 13,
                      numSeats: 4.0,
                    ),
                    SizedBox(width: 20),
                    TableWidget(
                      index: 5,
                      circleRadius: 13,
                      numSeats: 4.0,
                    ),
                    SizedBox(width: 20),
                    TableWidget(
                      index: 6,
                      circleRadius: 13,
                      numSeats: 2.0,
                    ),
                  ],
                ),
                // bar counter
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 20),
                    TableWidget(
                      index: 7,
                      circleRadius: 13,
                      numSeats: 7.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TableWidget extends StatelessWidget {
  final double circleRadius;
  final double numSeats;
  final int index;

  const TableWidget({
    Key? key,
    required this.circleRadius,
    required this.numSeats,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(242, 129, 228, 167),
                borderRadius: BorderRadius.circular(25),
              ),
              child: buildSeatsWidget(
                  numSeats: numSeats, circleRadius: circleRadius),
            ),
            tableName(index),
          ],
        ),
      ],
    );
  }

  Widget tableName(int index) {
    if (numSeats == 6.0) {
      return Text(
        "The big Table",
        style: AppStyles.text14PxRegular.copyWith(color: Colors.white),
      );
    } else if (numSeats == 7.0) {
      return Text(
        "bar counter",
        style: AppStyles.text14PxRegular.copyWith(color: Colors.white),
      );
    } else {
      return Text(
        "Table ${index}",
        style: AppStyles.text14PxRegular.copyWith(color: Colors.white),
      );
    }
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
              TextFrave(text: 'Free', fontSize: 20, color: Colors.white),
            ],
          ),
          Row(
            children: [
              Icon(Icons.circle, color: Color(0xff4A5660), size: 10),
              SizedBox(width: 10.0),
              TextFrave(
                text: 'Reserved',
                fontSize: 20,
                color: Color(0xff4A5660),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.circle, color: Colors.yellowAccent, size: 10),
              SizedBox(width: 10.0),
              TextFrave(
                text: 'Selected',
                fontSize: 20,
                color: Colors.yellowAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
