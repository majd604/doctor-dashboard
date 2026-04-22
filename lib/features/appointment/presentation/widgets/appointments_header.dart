import 'package:flutter/material.dart';

class AppointmentsHeader extends StatelessWidget {
  const AppointmentsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointments',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
        ),
        SizedBox(height: 6),
        Text(
          'Manage all patient appointments and update their status.',
          style: TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
        ),
      ],
    );
  }
}
