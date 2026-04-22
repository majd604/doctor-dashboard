// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/features/message/data/models/conversation_model.dart';
import 'package:doctor_dashboard/features/message/presentation/screens/dashboard_chat_screen.dart';
import 'package:doctor_dashboard/features/message/presentation/widgets/conversation_delete_button.dart';
import 'package:doctor_dashboard/features/message/presentation/widgets/conversation_doctor_avatar.dart';
import 'package:doctor_dashboard/features/message/presentation/widgets/conversation_open_button.dart';
import 'package:doctor_dashboard/features/message/presentation/widgets/conversation_time_badge.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConversationCard extends StatefulWidget {
  const ConversationCard({super.key, required this.conversation});

  final ConversationModel conversation;

  @override
  State<ConversationCard> createState() => _ConversationCardState();
}

class _ConversationCardState extends State<ConversationCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final conversation = widget.conversation;
    final timeFormatted = DateFormat('dd MMM • hh:mm a').format(conversation.lastMessageTime);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..translate(0, isHovering ? -4 : 0),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovering ? 0.09 : 0.05),
              blurRadius: isHovering ? 18 : 12,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: isHovering ? const Color(0xFF0B7A75).withOpacity(0.18) : Colors.transparent),
        ),
        child: Row(
          children: [
            ConversationDoctorAvatar(imageUrl: conversation.doctorImageUrl),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.userName,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
                        ),
                      ),
                      ConversationTimeBadge(time: timeFormatted),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    conversation.doctorName,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF0B7A75)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    conversation.lastMessage.isEmpty ? 'No messages yet' : conversation.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConversationDeleteButton(conversationId: conversation.id),
                const SizedBox(width: 12),
                ConversationOpenButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DashboardChatScreen(conversation: conversation)),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
