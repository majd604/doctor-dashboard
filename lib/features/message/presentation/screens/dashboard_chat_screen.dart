// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/features/message/data/models/conversation_model.dart';
import 'package:doctor_dashboard/features/message/presentation/widgets/chat_input_field.dart';
import 'package:doctor_dashboard/features/message/presentation/widgets/chat_messages_list.dart';
import 'package:flutter/material.dart';

class DashboardChatScreen extends StatelessWidget {
  const DashboardChatScreen({super.key, required this.conversation});

  final ConversationModel conversation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(conversation.doctorImageUrl)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversation.userName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
                ),
                Text(conversation.doctorName, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: ChatMessagesList(conversationId: conversation.id)),
          ChatInputField(conversationId: conversation.id),
        ],
      ),
    );
  }
}
