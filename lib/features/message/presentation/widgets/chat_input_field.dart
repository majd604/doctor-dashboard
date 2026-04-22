import 'package:doctor_dashboard/features/message/data/services/message_service.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController controller = TextEditingController();

  void sendMessage() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    await MessageService().sendMessage(
      conversationId: widget.conversationId,
      senderId: 'admin', // مهم
      senderType: 'doctor', // حتى يظهر يمين
      content: text,
    );

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Type a reply...",
                filled: true,
                fillColor: const Color(0xFFF3F4F6),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: sendMessage,
            child: Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(color: Color(0xFF0B7A75), shape: BoxShape.circle),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
