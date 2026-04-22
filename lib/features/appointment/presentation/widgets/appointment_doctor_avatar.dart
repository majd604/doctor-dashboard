// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppointmentDoctorAvatar extends StatelessWidget {
  const AppointmentDoctorAvatar({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: 68,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFF0B7A75).withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(Icons.person_rounded, color: Color(0xFF0B7A75), size: 28);
                },
              )
            : const Icon(Icons.person_rounded, color: Color(0xFF0B7A75), size: 28),
      ),
    );
  }
}
