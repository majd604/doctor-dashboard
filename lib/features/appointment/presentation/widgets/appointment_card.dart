// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/features/appointment/data/model/appointment_model.dart';
import 'package:doctor_dashboard/features/appointment/presentation/widgets/appointment_action_row.dart';
import 'package:doctor_dashboard/features/appointment/presentation/widgets/appointment_doctor_avatar.dart';
import 'package:doctor_dashboard/features/appointment/presentation/widgets/appointment_info_pill.dart';
import 'package:doctor_dashboard/features/appointment/presentation/widgets/appointment_status_chip.dart';
import 'package:doctor_dashboard/features/appointment/presentation/widgets/appointment_status_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key, required this.appointment});

  final AppointmentModel appointment;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final appointment = widget.appointment;
    final dateFormatted = DateFormat('dd MMM yyyy').format(appointment.date);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..translate(0, isHovering ? -4 : 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovering ? 0.09 : 0.05),
              blurRadius: isHovering ? 18 : 12,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: isHovering ? const Color(0xFF0B7A75).withOpacity(0.18) : Colors.transparent),
        ),
        child: Row(
          children: [
            AppointmentDoctorAvatar(imageUrl: appointment.doctorImageUrl),
            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          appointment.patientName,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
                        ),
                      ),
                      AppointmentStatusChip(status: appointment.status),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    appointment.doctorName,
                    style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appointment.doctorSpecialty ?? '',
                    style: const TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      AppointmentInfoPill(icon: Icons.calendar_today_outlined, text: dateFormatted),
                      AppointmentInfoPill(icon: Icons.access_time_rounded, text: appointment.time),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 18),

            SizedBox(
              width: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppointmentStatusDropdown(appointment: appointment),
                  const SizedBox(height: 16),
                  AppointmentActionsRow(appointment: appointment),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
