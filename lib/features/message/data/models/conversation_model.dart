import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  final String id;
  final String userId;
  final String userName;
  final String doctorId;
  final String doctorName;
  final String doctorImageUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String lastSenderId;
  final DateTime createdAt;

  ConversationModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.doctorId,
    required this.doctorName,
    required this.doctorImageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastSenderId,
    required this.createdAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json, String id) {
    return ConversationModel(
      id: id,
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      doctorId: json['doctorId'] ?? '',
      doctorName: json['doctorName'] ?? '',
      doctorImageUrl: json['doctorImageUrl'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      lastMessageTime: (json['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastSenderId: json['lastSenderId'] ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
