import 'package:cloud_firestore/cloud_firestore.dart';

class ChatbotModel {
  final String id;
  final String text;
  final String? imageUrl;
  final bool isUser;
  final DateTime timestamp;

  ChatbotModel({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.isUser,
    required this.timestamp,
  });

  factory ChatbotModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ChatbotModel(
      id: documentId,
      text: data['text'],
      imageUrl: data['imageUrl'],
      isUser: data['isUser'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'imageUrl': imageUrl,
      'isUser': isUser,
      'timestamp': timestamp,
    };
  }
}
