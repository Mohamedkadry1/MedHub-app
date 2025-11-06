class ReservationModel {
  final String reservationId; // Document ID
  final String doctorId;
  final String userId;
  final String status; // e.g., 'pending', 'confirmed', etc.
  // final DateTime timestamp;

  ReservationModel({
    required this.reservationId,
    required this.doctorId,
    required this.userId,
    required this.status,
    // required this.timestamp,
  });

  factory ReservationModel.fromMap(
      Map<String, dynamic> data, String reservationId) {
    return ReservationModel(
      reservationId: reservationId,
      doctorId: data['doctorId'] ?? '',
      userId: data['userId'] ?? '',
      status: data['status'] ?? '',
      // timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'userId': userId,
      'status': status,
      // 'timestamp': timestamp,
    };
  }
}
