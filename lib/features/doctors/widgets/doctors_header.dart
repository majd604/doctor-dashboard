// ignore_for_file: use_build_context_synchronously

import 'package:doctor_dashboard/core/helpers/app_snackbar.dart';
import 'package:doctor_dashboard/features/add_doctor_dialog/add_doctor_dialog.dart';
import 'package:doctor_dashboard/features/doctors/bloc/doctor_bloc.dart';
import 'package:doctor_dashboard/features/doctors/bloc/doctor_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsHeader extends StatelessWidget {
  const DoctorsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Doctors",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
              ),
              SizedBox(height: 6),
              Text("Manage doctors list and details", style: TextStyle(fontSize: 15, color: Color(0xFF6B7280))),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            final result = await showDialog(context: context, builder: (_) => const AddDoctorDialog());
            if (result == true) {
              context.read<DoctorBloc>().add(LoadDoctors());
              AppSnackbar.showSuccess(context, "Doctor added successfully.");
            }
          },
          icon: const Icon(Icons.add),
          label: const Text("Add Doctor"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0B7A75),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }
}
