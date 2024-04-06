import 'package:flutter/material.dart';

import '../constants/global_colors.dart';
import '../model/arm_chair_model.dart';
import '../widgets/build_btn.dart';
import '../widgets/seat_row.dart';
import '../widgets/table_booking_bottom_sheet.dart';
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
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: Color(0xff61C9A8),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<List<ArmChairsModel>>(
                      stream: _armChairsStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final chairs = snapshot.data ?? [];
                          return Column(
                            children: chairs.map((chair) {
                              return Column(
                                children: [
                                  SeatsRow(
                                    numSeats: chair.seats,
                                    freeSeats: chair.freeSeats,
                                    rowSeats: chair.rowSeats,
                                  ),
                                  SizedBox(height: 20.0),
                                ],
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 55.0),
                    _ItemsDescription(size: size),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 60,
            right: 60,
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildButton(
                context,
                text: "Reserve your table",
                color: AppColors.green,
                onPressed: () {
                  table_booking_bottom_sheet(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
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
