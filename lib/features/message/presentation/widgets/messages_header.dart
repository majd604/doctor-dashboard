import 'package:flutter/material.dart';

class MessagesHeader extends StatelessWidget {
  const MessagesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Messages',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
        ),
        SizedBox(height: 6),
        Text(
          'Manage patient conversations and reply from the dashboard.',
          style: TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
        ),
      ],
    );
  }
}
