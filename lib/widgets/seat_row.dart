import 'package:One_Bytes_Food/widgets/paint_chair.dart';
import 'package:flutter/material.dart';

class SeatsRow extends StatefulWidget {
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
  State<SeatsRow> createState() => _SeatsRowState();
}

class _SeatsRowState extends State<SeatsRow> {
  late List<bool> selectedSeats;

  @override
  void initState() {
    super.initState();
    selectedSeats = List.filled(widget.numSeats, false);
  }

// i have keep all of the selected seat into the provider and then display it according in the bottom sheet
  @override
  Widget build(BuildContext context) {
    if (selectedSeats.isEmpty) {
      return Container();
    }
    return Container(
      child: Row(
        children: List.generate(widget.numSeats, (i) {
          if (widget.freeSeats.contains(i + 1)) {
            return InkWell(
              onTap: () {
                print('Seat ${widget.rowSeats}${i + 1} selected.');
                setState(() {
                  selectedSeats[i] = !selectedSeats[i];
                });
              },
              child: PaintChair(
                color: selectedSeats[i] ? Colors.green : Colors.yellow,
              ),
            );
          }
          return PaintChair();
        }),
      ),
    );
  }
}
