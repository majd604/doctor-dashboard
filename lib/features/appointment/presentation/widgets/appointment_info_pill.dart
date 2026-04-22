import 'package:flutter/material.dart';

class AppointmentInfoPill extends StatelessWidget {
  const AppointmentInfoPill({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(14)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF0B7A75)),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 12.8, fontWeight: FontWeight.w700, color: Color(0xFF4B5563)),
          ),
        ],
      ),
    );
  }
}
