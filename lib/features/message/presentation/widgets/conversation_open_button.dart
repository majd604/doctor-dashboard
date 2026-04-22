// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ConversationOpenButton extends StatelessWidget {
  const ConversationOpenButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        height: 46,
        width: 46,
        decoration: BoxDecoration(
          color: const Color(0xFF0B7A75).withOpacity(0.10),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.arrow_forward_rounded, color: Color(0xFF0B7A75), size: 22),
      ),
    );
  }
}
