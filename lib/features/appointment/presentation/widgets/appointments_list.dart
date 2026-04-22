import 'package:doctor_dashboard/features/appointment/bloc/appointment_bloc.dart';
import 'package:doctor_dashboard/features/appointment/bloc/appointment_state.dart';
import 'package:doctor_dashboard/features/appointment/presentation/widgets/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsList extends StatelessWidget {
  const AppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AppointmentError) {
          return Center(
            child: Text(state.message, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          );
        }

        if (state is AppointmentLoaded && state.appointments.isEmpty) {
          return const Center(
            child: Text(
              'No appointments found',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF6B7280)),
            ),
          );
        }

        if (state is AppointmentLoaded) {
          final appointments = state.appointments;

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: appointments.length,
            separatorBuilder: (_, __) => const SizedBox(height: 18),
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return AppointmentCard(appointment: appointment);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
