// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/features/doctors/bloc/doctor_bloc.dart';
import 'package:doctor_dashboard/features/doctors/bloc/doctor_event.dart';
import 'package:doctor_dashboard/features/doctors/data/services/doctor_service.dart';
import 'package:doctor_dashboard/features/doctors/widgets/doctors_header.dart';
import 'package:doctor_dashboard/features/doctors/widgets/doctors_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorBloc(doctorService: DoctorService())..add(LoadDoctors()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FB),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              DoctorsHeader(),
              SizedBox(height: 24),
              Expanded(child: DoctorsList()),
            ],
          ),
        ),
      ),
    );
  }
}
