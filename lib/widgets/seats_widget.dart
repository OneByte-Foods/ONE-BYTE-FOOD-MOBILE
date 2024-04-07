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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              onSeatPressed(4);
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: circleRadius,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              onSeatPressed(1);
            },
            child: CircleAvatar(
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
                    backgroundColor:
                        selectedSeats.contains(i) ? Colors.blue : Colors.white,
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
                    backgroundColor:
                        selectedSeats.contains(i) ? Colors.blue : Colors.white,
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
                    backgroundColor:
                        selectedSeats.contains(i) ? Colors.blue : Colors.white,
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
                    backgroundColor:
                        selectedSeats.contains(i) ? Colors.blue : Colors.white,
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
                backgroundColor:
                    selectedSeats.contains(i) ? Colors.blue : Colors.white,
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
