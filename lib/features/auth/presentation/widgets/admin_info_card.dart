import 'package:flutter/material.dart';

class AdminInfoCard extends StatelessWidget {
  const AdminInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD6EFFF)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: Color(0xFF0B7A75), size: 22),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Only authorized admin accounts can access the dashboard.',
              style: TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF4B5563), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
