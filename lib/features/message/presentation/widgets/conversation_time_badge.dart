import 'package:flutter/material.dart';

class ConversationTimeBadge extends StatelessWidget {
  const ConversationTimeBadge({super.key, required this.time});

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(999)),
      child: Text(
        time,
        style: const TextStyle(fontSize: 12.5, color: Color(0xFF6B7280), fontWeight: FontWeight.w700),
      ),
    );
  }
}
