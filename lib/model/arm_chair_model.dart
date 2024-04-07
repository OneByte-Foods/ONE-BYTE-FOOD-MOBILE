import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class ArmChairsModel {
  final String rowSeats;
  final int seats;
  final List<int> freeSeats;

  ArmChairsModel({
    required this.rowSeats,
    required this.seats,
    required this.freeSeats,
  });

  static List<ArmChairsModel> listChairs = [];
}

Stream<List<ArmChairsModel>> fetchArmChairsData() {
  DatabaseReference databaseReference = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        "https://one-bytes-backend-default-rtdb.asia-southeast1.firebasedatabase.app/",
  ).ref().child('chairs');

  Stream<DatabaseEvent> events = databaseReference.onValue;

  return events.map((event) {
    try {
      DataSnapshot dataSnapshot = event.snapshot;
      List<ArmChairsModel> chairs = [];

      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> data =
            dataSnapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          String rowSeats = key;
          int seats = value['seats'] ?? 0;
          List<int> freeSeats = List<int>.from(value['freeSeats'] ?? []);
          chairs.add(ArmChairsModel(
            rowSeats: rowSeats,
            seats: seats,
            freeSeats: freeSeats,
          ));
        });
      } else {
        print('DataSnapshot is null');
      }

      return chairs;
    } catch (error) {
      print("Error fetching arm chairs data: $error");
      return [];
    }
  });
}
