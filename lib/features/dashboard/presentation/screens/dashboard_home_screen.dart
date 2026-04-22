// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/features/dashboard/presentation/widgets/dashboard_grid.dart';
import 'package:doctor_dashboard/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:flutter/material.dart';

class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            DashboardHeader(),
            SizedBox(height: 28),
            Expanded(child: DashboardGrid()),
          ],
        ),
      ),
    );
  }
}
