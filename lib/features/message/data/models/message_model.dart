import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String senderId;
  final String senderType;
  final String content;
  final DateTime createdAt;
  final bool isSeen;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.senderType,
    required this.content,
    required this.createdAt,
    required this.isSeen,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, String id) {
    return MessageModel(
      id: id,
      senderId: json['senderId'] ?? '',
      senderType: json['senderType'] ?? '',
      content: json['content'] ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isSeen: json['isSeen'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'senderType': senderType,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
      'isSeen': isSeen,
    };
  }
}
