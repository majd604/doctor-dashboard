import 'package:doctor_dashboard/features/appointment/data/model/appointment_model.dart';
import 'package:equatable/equatable.dart';

abstract class AppointmentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final List<AppointmentModel> appointments;

  AppointmentLoaded(this.appointments);

  @override
  List<Object?> get props => [appointments];
}

class AppointmentError extends AppointmentState {
  final String message;

  AppointmentError({required this.message});

  @override
  List<Object?> get props => [message];
}
