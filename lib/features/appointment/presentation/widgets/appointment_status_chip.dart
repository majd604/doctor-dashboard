// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppointmentStatusChip extends StatelessWidget {
  const AppointmentStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final statusData = _getStatusData(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(color: statusData.color.withOpacity(0.12), borderRadius: BorderRadius.circular(999)),
      child: Text(
        statusData.label,
        style: TextStyle(color: statusData.color, fontSize: 12.5, fontWeight: FontWeight.w800),
      ),
    );
  }
}

class _AppointmentStatusData {
  final String label;
  final Color color;

  _AppointmentStatusData({required this.label, required this.color});
}

_AppointmentStatusData _getStatusData(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
      return _AppointmentStatusData(label: 'Completed', color: const Color(0xFF16A34A));
    case 'cancelled':
      return _AppointmentStatusData(label: 'Cancelled', color: const Color(0xFFDC2626));
    default:
      return _AppointmentStatusData(label: 'Pending', color: const Color(0xFFF59E0B));
  }
}
