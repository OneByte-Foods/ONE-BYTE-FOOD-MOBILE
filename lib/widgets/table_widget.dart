import 'package:One_Bytes_Food/constants/app_style.dart';
import 'package:One_Bytes_Food/widgets/seats_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/seat_provider.dart';

class TableWidget extends StatelessWidget {
  final double circleRadius;
  final double numSeats;
  final int index;
  final int tableIndex;
  final int floorIndex;

  const TableWidget(
      {Key? key,
      required this.circleRadius,
      required this.numSeats,
      required this.index,
      required this.tableIndex,
      required this.floorIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SeatProvider>(
      builder: (context, seatModel, child) {
        final selectedSeats = seatModel
                .floorTableSeatColors[floorIndex]?[tableIndex]?.keys
                .toSet() ??
            {};

        void handleSeatPressed(int seatIndex) {
          int totalSeats = numSeats.toInt();
          int seatsPerRow = totalSeats ~/ 2;

          int rowIndex = seatIndex ~/ seatsPerRow;
          int columnIndex = seatIndex % seatsPerRow;

          int seatNumber = rowIndex * seatsPerRow + columnIndex + 1;

          seatModel.toggleSeat(floorIndex, tableIndex, seatNumber, index);
        }

        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(242, 129, 228, 167),
                borderRadius: BorderRadius.circular(25),
              ),
              child: SeatsWidget(
                floorIndex: floorIndex,
                onSeatPressed: handleSeatPressed,
                numSeats: numSeats,
                circleRadius: circleRadius,
                selectedSeats: selectedSeats,
              ),
            ),
            _buildTableName(index, numSeats),
          ],
        );
      },
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
