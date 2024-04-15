import 'package:One_Bytes_Food/widgets/circle_avatar_widget.dart';
import 'package:flutter/material.dart';

class SeatsWidget extends StatefulWidget {
  final double numSeats;
  final double circleRadius;
  final Set<int> selectedSeats;
  final Function(int) onSeatPressed;
  final int floorIndex;

  SeatsWidget({
    required this.numSeats,
    required this.floorIndex,
    required this.circleRadius,
    required this.selectedSeats,
    required this.onSeatPressed,
  });

  @override
  _SeatsWidgetState createState() => _SeatsWidgetState();
}

// we need a listner which listens the data from the firebase ani tespachi cheii update garne ani update gareko data lai display garne
class _SeatsWidgetState extends State<SeatsWidget> {
  @override
  Widget build(BuildContext context) {
    final selectedSeats = widget.selectedSeats
        .where((seatIndex) => seatIndex ~/ 10 == widget.floorIndex)
        .toSet();

    if (widget.numSeats == 2) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < widget.numSeats; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  int seatIndex = widget.floorIndex * 10 + i;
                  widget.onSeatPressed(seatIndex);
                },
                child: CircleAvatar(
                  child: selectedSeats.contains(widget.floorIndex * 10 + i + 1)
                      ? buildCircleAvatar(radius: 20)
                      : Text((i + 1).toString()),
                  backgroundColor: Colors.white,
                  radius: widget.circleRadius,
                ),
              ),
            ),
        ],
      );
    } else if (widget.numSeats == 4) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < widget.numSeats / 2; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      int seatIndex = widget.floorIndex * 10 + i;
                      widget.onSeatPressed(seatIndex);
                    },
                    child: CircleAvatar(
                      child:
                          selectedSeats.contains(widget.floorIndex * 10 + i + 1)
                              ? buildCircleAvatar(radius: 30)
                              : Text((i + 1).toString()),
                      backgroundColor: Colors.white,
                      radius: widget.circleRadius,
                    ),
                  ),
                )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = widget.numSeats ~/ 2; i < widget.numSeats; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      int seatIndex = widget.floorIndex * 10 + i;
                      widget.onSeatPressed(seatIndex);
                    },
                    child: CircleAvatar(
                      child:
                          selectedSeats.contains(widget.floorIndex * 10 + i + 1)
                              ? buildCircleAvatar(radius: 20)
                              : Text((i + 1).toString()),
                      backgroundColor: Colors.white,
                      radius: widget.circleRadius,
                    ),
                  ),
                )
            ],
          ),
        ],
      );
    } else if (widget.numSeats == 6) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < widget.numSeats / 2; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      int seatIndex = widget.floorIndex * 10 + i;
                      widget.onSeatPressed(seatIndex);
                    },
                    child: CircleAvatar(
                      child:
                          selectedSeats.contains(widget.floorIndex * 10 + i + 1)
                              ? buildCircleAvatar(radius: 20)
                              : Text((i + 1).toString()),
                      backgroundColor: Colors.white,
                      radius: widget.circleRadius,
                    ),
                  ),
                )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = widget.numSeats ~/ 2; i < widget.numSeats; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      int seatIndex = widget.floorIndex * 10 + i;
                      widget.onSeatPressed(seatIndex);
                    },
                    child: CircleAvatar(
                      child:
                          selectedSeats.contains(widget.floorIndex * 10 + i + 1)
                              ? buildCircleAvatar(radius: 20)
                              : Text((i + 1).toString()),
                      backgroundColor: Colors.white,
                      radius: widget.circleRadius,
                    ),
                  ),
                )
            ],
          ),
        ],
      );
    } else if (widget.numSeats == 7) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < widget.numSeats; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  int seatIndex = widget.floorIndex * 10 + i;
                  widget.onSeatPressed(seatIndex);
                },
                child: CircleAvatar(
                  child: selectedSeats.contains(widget.floorIndex * 10 + i + 1)
                      ? buildCircleAvatar(radius: 20)
                      : Text((i + 1).toString()),
                  backgroundColor: Colors.white,
                  radius: widget.circleRadius,
                ),
              ),
            )
        ],
      );
    } else {
      return Container();
    }
  }
}
