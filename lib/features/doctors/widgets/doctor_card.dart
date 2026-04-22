// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/core/dialog/app_dialog.dart';
import 'package:doctor_dashboard/core/helpers/app_snackbar.dart';
import 'package:doctor_dashboard/features/add_doctor_dialog/add_doctor_dialog.dart';
import 'package:doctor_dashboard/features/doctors/bloc/doctor_bloc.dart';
import 'package:doctor_dashboard/features/doctors/bloc/doctor_event.dart';
import 'package:doctor_dashboard/features/doctors/data/models/doctor_model.dart';
import 'package:doctor_dashboard/features/doctors/data/services/doctor_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorCard extends StatefulWidget {
  const DoctorCard({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.identity()..translate(0, isHovering ? -4 : 0),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovering ? 0.10 : 0.04),
              blurRadius: isHovering ? 18 : 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 56,
                width: 56,
                color: const Color(0xFF0B7A75).withOpacity(0.12),
                child: widget.doctor.imageUrl.isNotEmpty
                    ? Image.network(
                        widget.doctor.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person, color: Color(0xFF0B7A75));
                        },
                      )
                    : const Icon(Icons.person, color: Color(0xFF0B7A75)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.doctor.name,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
                  ),
                  const SizedBox(height: 4),
                  Text(widget.doctor.specialty, style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (_) => AddDoctorDialog(doctor: widget.doctor),
                    );
                    if (result == true && context.mounted) {
                      context.read<DoctorBloc>().add(LoadDoctors());
                      AppSnackbar.showSuccess(context, 'Doctor Updated Successfully');
                    }
                  },
                  icon: const Icon(Icons.edit_outlined),
                  color: Colors.blueGrey,
                ),
                IconButton(
                  onPressed: () async {
                    final confirm = await AppDialog.showDeleteDialog(context: context);

                    if (confirm == true) {
                      await DoctorService().deleteDoctor(widget.doctor.id);

                      if (!context.mounted) return;

                      context.read<DoctorBloc>().add(LoadDoctors());

                      AppSnackbar.showSuccess(context, 'Doctor deleted');
                    }
                  },
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
