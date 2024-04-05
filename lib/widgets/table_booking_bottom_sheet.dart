import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../model/date_time_model.dart';

Future table_booking_bottom_sheet(BuildContext context) {
  int? tableNo = 0;
  final size = MediaQuery.of(context).size;

  return showMaterialModalBottomSheet(
    expand: false,
    elevation: 0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(36),
      topRight: Radius.circular(36),
    )),
    context: context,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.7,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Positioned(
                  top: 100,
                  child: Column(
                    children: [
                      // Dates ListView
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        height: 70,
                        width: size.width,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: DateTimeModel.listDate.length,
                          itemBuilder: (_, i) =>
                              _ItemDate(date: DateTimeModel.listDate[i]),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Times ListView
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        height: 40,
                        width: size.width,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: DateTimeModel.listTime.length,
                          itemBuilder: (_, i) =>
                              _ItemTime(time: DateTimeModel.listTime[i]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class _ItemTime extends StatelessWidget {
  final String time;

  const _ItemTime({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            time,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class _ItemDate extends StatelessWidget {
  final DateTimeModel date;

  const _ItemDate({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          decoration: BoxDecoration(
            color: Colors.blue, // Change color as needed
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '${date.day} ${date.number}',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
