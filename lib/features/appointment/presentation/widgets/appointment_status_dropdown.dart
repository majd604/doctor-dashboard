import 'package:doctor_dashboard/core/helpers/app_snackbar.dart';
import 'package:doctor_dashboard/features/appointment/bloc/appointment_bloc.dart';
import 'package:doctor_dashboard/features/appointment/bloc/appointment_event.dart';
import 'package:doctor_dashboard/features/appointment/data/model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentStatusDropdown extends StatelessWidget {
  const AppointmentStatusDropdown({super.key, required this.appointment});

  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: appointment.status,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF0B7A75), width: 1.3),
        ),
      ),
      items: const [
        DropdownMenuItem(value: 'pending', child: Text('Pending')),
        DropdownMenuItem(value: 'completed', child: Text('Completed')),
        DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
      ],
      onChanged: (value) {
        if (value == null) return;

        context.read<AppointmentBloc>().add(UpdateAppointmentStatus(appointmentId: appointment.id, newStatus: value));

        AppSnackbar.showSuccess(context, 'Appointment status updated');
      },
    );
  }
}
