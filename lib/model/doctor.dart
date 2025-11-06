import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDoctorModel {
  final String id;
  final String msg;
  final String receiverId;
  final String senderId;
  final DateTime timestamp;
  final bool isDoctor;
  final String? imageUrl;


  ChatDoctorModel({
    required this.imageUrl,
    required this.id,
    required this.msg,
    required this.receiverId,
    required this.senderId,
    required this.timestamp,
    required this.isDoctor,
  });

  factory ChatDoctorModel.fromMap(Map<String, dynamic> data, String id) {
    return ChatDoctorModel(
      imageUrl: data['imageUrl'],
      id: id,
      msg: data['msg'] ?? '',
      receiverId: data['receiverId'] ?? '',
      senderId: data['senderId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      isDoctor: data['isDoctor'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl':imageUrl,
      'msg': msg,
      'receiverId': receiverId,
      'senderId': senderId,
      'timestamp': timestamp,
      'isDoctor': isDoctor,
    };
  }
}
