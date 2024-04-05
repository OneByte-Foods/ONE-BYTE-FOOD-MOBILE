import 'package:One_Bytes_Food/widgets/paint_chair.dart';
import 'package:flutter/material.dart';

class SeatsRow extends StatelessWidget {
  final int numSeats;
  final List<int> freeSeats;
  final String rowSeats;

  const SeatsRow({
    Key? key,
    required this.rowSeats,
    required this.numSeats,
    required this.freeSeats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(numSeats, (i) {
          if (freeSeats.contains(i + 1)) {
            return InkWell(
              onTap: () => print('Seat ${rowSeats}${i + 1} selected.'),
              child: PaintChair(
                color: Colors.white,
              ),
            );
          }
          return PaintChair();
        }),
      ),
    );
  }
}
