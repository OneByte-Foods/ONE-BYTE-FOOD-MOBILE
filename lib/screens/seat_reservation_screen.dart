import 'dart:ui';

import 'package:One_Bytes_Food/model/date_time_model.dart';
import 'package:One_Bytes_Food/widgets/textFrave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cinema/cinema_bloc.dart';
import '../model/arm_chair_model.dart';
import '../widgets/seat_row.dart';

class SeatReservationScreen extends StatelessWidget {
  final String titleMovie;

  const SeatReservationScreen({
    Key? key,
    required this.titleMovie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: size.height, width: size.width, color: Color(0xff21242C)),
          Container(
            height: size.height * .7,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/Onboarding_2.gif"))),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Color(0xff21242C),
                  Color(0xff21242C).withOpacity(.9),
                  Color(0xff21242C).withOpacity(.1),
                ]),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 20.0,
                    sigmaY: 20.0,
                  ),
                  child: Container(
                    color: Color(0xff21242C).withOpacity(0.1),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFrave(
                        text: titleMovie,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)
                  ],
                )),
          ),
          Positioned(
              top: 100,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20.0),
                      height: 100,
                      width: size.width,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: DateTimeModel.listDate.length,
                        itemBuilder: (_, i) =>
                            _ItemDate(date: DateTimeModel.listDate[i]),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      padding: EdgeInsets.only(left: 20.0),
                      height: 40,
                      width: size.width,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: DateTimeModel.listTime.length,
                          itemBuilder: (_, i) =>
                              _ItemTime(time: DateTimeModel.listTime[i])),
                    ),
                    SizedBox(height: 55.0),
                    Container(
                        height: 240,
                        width: size.width,
                        child: Column(
                          children: List.generate(
                              ArmChairsModel.listChairs.length,
                              (i) => SeatsRow(
                                    numSeats:
                                        ArmChairsModel.listChairs[i].seats,
                                    freeSeats:
                                        ArmChairsModel.listChairs[i].freeSeats,
                                    rowSeats:
                                        ArmChairsModel.listChairs[i].rowSeats,
                                  )),
                        )),
                    SizedBox(height: 55.0),
                    _ItemsDescription(size: size)
                  ],
                ),
              )),
          Positioned(
            left: 60,
            right: 60,
            bottom: 20,
            child: InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8.0)),
                child: TextFrave(
                    text: 'Reserve your table \$ 55.0',
                    fontWeight: FontWeight.bold),
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
              TextFrave(text: 'Free', fontSize: 20, color: Colors.white)
            ],
          ),
          Row(
            children: [
              Icon(Icons.circle, color: Color(0xff4A5660), size: 10),
              SizedBox(width: 10.0),
              TextFrave(
                  text: 'Reserved', fontSize: 20, color: Color(0xff4A5660))
            ],
          ),
          Row(
            children: [
              Icon(Icons.circle, color: Colors.amber, size: 10),
              SizedBox(width: 10.0),
              TextFrave(text: 'Selected', fontSize: 20, color: Colors.amber)
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemTime extends StatelessWidget {
  final String time;

  const _ItemTime({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cinemaBloc = BlocProvider.of<CinemaBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: () => cinemaBloc.add(OnSelectedTimeEvent(time)),
        child: BlocBuilder<CinemaBloc, CinemaState>(
          builder: (context, state) => Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              decoration: BoxDecoration(
                  color: state.time == time ? Colors.amber : Color(0xff4D525A),
                  borderRadius: BorderRadius.circular(8.0)),
              child: TextFrave(text: time, color: Colors.white, fontSize: 16)),
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
    final cinemaBloc = BlocProvider.of<CinemaBloc>(context);

    return InkWell(
      onTap: () => cinemaBloc.add(OnSelectedDateEvent(date.number)),
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: BlocBuilder<CinemaBloc, CinemaState>(
          builder: (context, state) => Container(
            height: 100,
            width: 75,
            decoration: BoxDecoration(
                color: state.date == date.number
                    ? Colors.amber
                    : Color(0xff4A5660),
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle,
                    color: Color(0xff21242C).withOpacity(.8), size: 12),
                SizedBox(height: 10.0),
                TextFrave(text: date.day, color: Colors.white, fontSize: 17),
                SizedBox(height: 5.0),
                TextFrave(text: date.number, color: Colors.white, fontSize: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
