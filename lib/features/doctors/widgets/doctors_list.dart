import 'package:doctor_dashboard/features/doctors/bloc/doctor_bloc.dart';
import 'package:doctor_dashboard/features/doctors/bloc/doctor_state.dart';
import 'package:doctor_dashboard/features/doctors/widgets/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorBloc, DoctorState>(
      builder: (context, state) {
        if (state is DoctorLoading) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF0B7A75)));
        }

        if (state is DoctorError) {
          return Center(child: Text(state.message));
        }

        if (state is DoctorLoaded && state.doctors.isEmpty) {
          return const Center(child: Text('No doctors found'));
        }

        if (state is DoctorLoaded) {
          final doctors = state.doctors;

          return ListView.separated(
            itemCount: doctors.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final doctor = doctors[index];

              return DoctorCard(doctor: doctor);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
