import 'package:One_Bytes_Food/constants/app_style.dart';
import 'package:One_Bytes_Food/model/seat_model.dart';
import 'package:One_Bytes_Food/widgets/seats_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Consumer<SeatModel>(
      builder: (context, seatModel, child) {
        final selectedSeats = seatModel.seatColors.keys.toSet();

        void handleSeatPressed(int seatIndex) {
          seatModel.toggleSeatColor(seatIndex);
        }

        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(242, 129, 228, 167),
                borderRadius: BorderRadius.circular(25),
              ),
              child: buildSeatsWidget(
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
