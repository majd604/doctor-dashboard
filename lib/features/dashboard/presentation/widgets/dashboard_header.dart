import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dashboard",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
              ),
              SizedBox(height: 6),
              Text(
                "Manage doctors, appointments, and patient messages",
                style: TextStyle(fontSize: 15, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Container(
          height: 54,
          width: 54,
          decoration: BoxDecoration(color: const Color(0xFFE8F7F6), borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.admin_panel_settings_rounded, color: Color(0xFF0B7A75), size: 28),
        ),
      ],
    );
  }
}
