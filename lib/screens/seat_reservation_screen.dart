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
            width: size.width * .99,
            height: size.height * .75,
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
                _buildTables(),
                SizedBox(height: 10),
                _buildBarCounter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeatInformation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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

  Widget _buildTables() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTableRow(1, 6.0),
              _buildTableRow(2, 2.0),
              _buildTableRow(3, 2.0),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTableRow(4, 4.0),
              _buildTableRow(5, 4.0),
              _buildTableRow(6, 2.0),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTableRow(7, 4.0),
              _buildTableRow(8, 4.0),
              _buildTableRow(9, 2.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(int index, double numSeats) {
    return Row(
      children: [
        TableWidget(
          index: index,
          circleRadius: 13,
          numSeats: numSeats,
        ),
      ],
    );
  }

  Widget _buildBarCounter() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Row(
        children: [
          TableWidget(
            index: 7,
            circleRadius: 13,
            numSeats: 7.0,
          ),
        ],
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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(242, 129, 228, 167),
            borderRadius: BorderRadius.circular(25),
          ),
          child: buildSeatsWidget(
            numSeats: numSeats,
            circleRadius: circleRadius,
          ),
        ),
        _buildTableName(index, numSeats),
      ],
    );
  }

  Widget _buildTableName(int index, double numSeats) {
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
        "Table $index",
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
          _buildSeatStatusWidget('Free', Colors.white),
          _buildSeatStatusWidget('Reserved', Color(0xff4A5660)),
          _buildSeatStatusWidget('Selected', Colors.yellowAccent),
        ],
      ),
    );
  }

  Widget _buildSeatStatusWidget(String text, Color color) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 10),
        SizedBox(width: 10.0),
        TextFrave(text: text, fontSize: 20, color: color),
      ],
    );
  }
}
