import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// تحميل كل المواعيد
class LoadAppointments extends AppointmentEvent {}

// تحديث الحالة
class UpdateAppointmentStatus extends AppointmentEvent {
  final String appointmentId;
  final String newStatus;

  UpdateAppointmentStatus({required this.appointmentId, required this.newStatus});

  @override
  List<Object?> get props => [appointmentId, newStatus];
}

// حذف موعد
class DeleteAppointment extends AppointmentEvent {
  final String appointmentId;

  DeleteAppointment({required this.appointmentId});

  @override
  List<Object?> get props => [appointmentId];
}

class RescheduleAppointment extends AppointmentEvent {
  final String appointmentId;
  final DateTime newDate;
  final String newTime;
  RescheduleAppointment({required this.appointmentId, required this.newDate, required this.newTime});
  @override
  List<Object> get props => [appointmentId, newDate, newTime];
}
