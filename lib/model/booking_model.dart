class Booking {
  String id;
  int seatNumber;
  String status;
  String tableType;
  String userProfilePic;
  String userEmail;
  String userName;

  Booking({
    required this.id,
    required this.seatNumber,
    required this.status,
    required this.tableType,
    required this.userProfilePic,
    required this.userEmail,
    required this.userName,
  });

  factory Booking.fromMap(Map<String, dynamic> data, String id) {
    return Booking(
      id: id,
      seatNumber: data['seatNumber'],
      status: data['status'],
      tableType: data['tableType'],
      userProfilePic: data['useProfilePic'],
      userEmail: data['userEmail'],
      userName: data['userName'],
    );
  }
}
