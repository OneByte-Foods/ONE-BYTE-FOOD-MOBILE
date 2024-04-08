import 'package:One_Bytes_Food/widgets/circle_avatar_widget.dart';
import 'package:flutter/material.dart';

Widget buildSeatsWidget({
  required double numSeats,
  required double circleRadius,
  required Set<int> selectedSeats,
  required Function(int) onSeatPressed,
}) {
  if (numSeats == 2) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < numSeats; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                onSeatPressed(i);
              },
              child: CircleAvatar(
                child: selectedSeats.contains(i)
                    ? buildCircleAvatar(radius: 20)
                    : Text((i + 1).toString()),
                backgroundColor: Colors.white,
                radius: circleRadius,
              ),
            ),
          ),
      ],
    );
  } else if (numSeats == 4) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < numSeats / 2; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    onSeatPressed(i);
                  },
                  child: CircleAvatar(
                    child: selectedSeats.contains(i)
                        ? buildCircleAvatar(radius: 30)
                        : Text((i + 1).toString()),
                    backgroundColor: Colors.white,
                    radius: circleRadius,
                  ),
                ),
              )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = numSeats ~/ 2; i < numSeats; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    onSeatPressed(i);
                  },
                  child: CircleAvatar(
                    child: selectedSeats.contains(i)
                        ? buildCircleAvatar(radius: 20)
                        : Text((i + 1).toString()),
                    backgroundColor: Colors.white,
                    radius: circleRadius,
                  ),
                ),
              )
          ],
        ),
      ],
    );
  } else if (numSeats == 6) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < numSeats / 2; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    onSeatPressed(i);
                  },
                  child: CircleAvatar(
                    child: selectedSeats.contains(i)
                        ? buildCircleAvatar(radius: 20)
                        : Text((i + 1).toString()),
                    backgroundColor: Colors.white,
                    radius: circleRadius,
                  ),
                ),
              )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = numSeats ~/ 2; i < numSeats; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    onSeatPressed(i);
                  },
                  child: CircleAvatar(
                    child: Text((i + 1).toString()),
                    backgroundColor: Colors.white,
                    radius: circleRadius,
                  ),
                ),
              )
          ],
        ),
      ],
    );
  } else if (numSeats == 7) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < numSeats; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                onSeatPressed(i);
              },
              child: CircleAvatar(
                child: selectedSeats.contains(i)
                    ? buildCircleAvatar(radius: 20)
                    : Text((i + 1).toString()),
                backgroundColor: Colors.white,
                radius: circleRadius,
              ),
            ),
          )
      ],
    );
  } else {
    return Container();
  }
}
