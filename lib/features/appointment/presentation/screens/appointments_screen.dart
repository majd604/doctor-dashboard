// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/features/appointment/bloc/appointment_bloc.dart';
import 'package:doctor_dashboard/features/appointment/bloc/appointment_event.dart';
import 'package:doctor_dashboard/features/appointment/data/services/appointment_service.dart';
import 'package:doctor_dashboard/features/appointment/presentation/widgets/appointments_header.dart';
import 'package:doctor_dashboard/features/appointment/presentation/widgets/appointments_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppointmentBloc(appointmentService: AppointmentService())..add(LoadAppointments()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FB),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              AppointmentsHeader(),
              SizedBox(height: 24),
              Expanded(child: AppointmentsList()),
            ],
          ),
        ),
      ),
    );
  }
}
