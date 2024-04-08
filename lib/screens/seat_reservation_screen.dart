import 'package:One_Bytes_Food/widgets/table_widget.dart';
import 'package:flutter/material.dart';

import '../constants/app_style.dart';
import '../constants/global_colors.dart';
import '../widgets/build_btn.dart';
import '../widgets/item_description_widget.dart';
import '../widgets/table_booking_bottom_sheet.dart';

class SeatReservationScreen extends StatefulWidget {
  const SeatReservationScreen({Key? key}) : super(key: key);

  @override
  State<SeatReservationScreen> createState() => _SeatReservationScreenState();
}

class _SeatReservationScreenState extends State<SeatReservationScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<int> _floors = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        child: Row(
          children: [
            for (int i = 0; i < _floors.length; i++)
              _buildPage1(size, _floors[i]),
          ],
        ),
      ),
    );
  }

  Widget _buildPage1(Size size, int floor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Floor $floor", style: AppStyles.text20PxRegular),
          Center(
            child: Container(
              width: size.width * .90,
              height: size.height * .77,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppColors.green,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  _buildSeatInformation(),
                  _buildTables(floor),
                  _buildBarCounter(floor),
                  SizedBox(height: 10),
                  ItemsDescription(size: size)
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          buildButton(
            context,
            text: "Reserve Table",
            color: Color(0XFF048BA8),
            width: MediaQuery.of(context).size.width * .80,
            onPressed: () {
              table_booking_bottom_sheet(context);
            },
          )
        ],
      ),
    );
  }

  Widget _buildSeatInformation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // this all datashall also be rendered in real time using stream builder and all
        _buildSeatInfoText(" 4 seats available"),
        _buildSeatInfoText("27 person"),
      ],
    );
  }

  Widget _buildSeatInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text(
        text,
        style: AppStyles.text16PxRegular.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildTables(int floor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTableRow(1, 6.0, 1, floor),
              _buildTableRow(2, 2.0, 2, floor),
              _buildTableRow(3, 2.0, 3, floor),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTableRow(4, 4.0, 4, floor),
              _buildTableRow(5, 4.0, 5, floor),
              _buildTableRow(6, 2.0, 6, floor),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTableRow(7, 4.0, 7, floor),
              _buildTableRow(8, 4.0, 8, floor),
              _buildTableRow(9, 2.0, 9, floor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(
      int index, double numSeats, int tableIndex, int floorIndex) {
    return Row(
      children: [
        TableWidget(
          floorIndex: floorIndex,
          index: index,
          circleRadius: 13,
          numSeats: numSeats,
          tableIndex: tableIndex,
        ),
      ],
    );
  }

  Widget _buildBarCounter(int floorIndex) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Row(
        children: [
          TableWidget(
            floorIndex: floorIndex,
            index: 7,
            circleRadius: 13,
            numSeats: 7.0,
            tableIndex: 10,
          ),
        ],
      ),
    );
  }
}
