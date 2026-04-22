import 'package:doctor_dashboard/features/message/data/services/message_service.dart';
import 'package:doctor_dashboard/features/message/presentation/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key, required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MessageService().getMessages(conversationId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final messages = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];

            final isMe = message.senderType == 'doctor';

            return ChatBubble(message: message.content, isMe: isMe);
          },
        );
      },
    );
  }
}
