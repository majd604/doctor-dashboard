// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AdminLoginHeader extends StatelessWidget {
  const AdminLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 110,
          width: 110,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F7F6),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(color: const Color(0xFF0B7A75).withOpacity(0.12), blurRadius: 18, offset: const Offset(0, 8)),
            ],
          ),
          child: Image.asset('images/logo/doctor-app-logo.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 24),
        const Text(
          'Admin Login',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800, color: Color(0xFF1F2937), letterSpacing: -0.6),
        ),
        const SizedBox(height: 10),
        const Text(
          'Sign in to manage doctors,appointments, and patient messages.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
