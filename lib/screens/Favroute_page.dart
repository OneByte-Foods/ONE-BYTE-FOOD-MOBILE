import 'package:One_Bytes_Food/model/arm_chair_model.dart';
import 'package:One_Bytes_Food/widgets/seat_row.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Stream<List<ArmChairsModel>> _armChairsStream;

  @override
  void initState() {
    super.initState();
    _armChairsStream = fetchArmChairsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(
          child: StreamBuilder<List<ArmChairsModel>>(
            stream: _armChairsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('No data available.'),
                );
              } else {
                final chairs = snapshot.data!;
                return ListView.builder(
                  itemCount: chairs.length,
                  itemBuilder: (context, index) {
                    final chair = chairs[index];
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
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
