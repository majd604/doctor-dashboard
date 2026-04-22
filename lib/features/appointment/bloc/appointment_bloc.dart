import 'package:doctor_dashboard/features/appointment/bloc/appointment_event.dart';
import 'package:doctor_dashboard/features/appointment/bloc/appointment_state.dart';
import 'package:doctor_dashboard/features/appointment/data/services/appointment_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentService appointmentService;

  AppointmentBloc({required this.appointmentService}) : super(AppointmentInitial()) {
    // تحميل المواعيد
    on<LoadAppointments>((event, emit) async {
      emit(AppointmentLoading());
      try {
        final appointments = await appointmentService.getAllAppointments();
        emit(AppointmentLoaded(appointments));
      } catch (e) {
        emit(AppointmentError(message: 'Failed to load appointments'));
      }
    });

    // تحديث الحالة
    on<UpdateAppointmentStatus>((event, emit) async {
      try {
        await appointmentService.updateAppointmentStatus(event.appointmentId, event.newStatus);

        final appointments = await appointmentService.getAllAppointments();
        emit(AppointmentLoaded(appointments));
      } catch (e) {
        emit(AppointmentError(message: 'Failed to update status'));
      }
    });

    // حذف موعد
    on<DeleteAppointment>((event, emit) async {
      try {
        await appointmentService.deleteAppointment(event.appointmentId);

        final appointments = await appointmentService.getAllAppointments();
        emit(AppointmentLoaded(appointments));
      } catch (e) {
        emit(AppointmentError(message: 'Failed to delete appointment'));
      }
    });

    // إعادة جدولة موعد
    on<RescheduleAppointment>((event, emit) async {
      try {
        await appointmentService.rescheduleAppointment(
          appointmentId: event.appointmentId,
          newDate: event.newDate,
          newTime: event.newTime,
        );
        final appointments = await appointmentService.getAllAppointments();
        emit(AppointmentLoaded(appointments));
      } catch (e) {
        emit(AppointmentError(message: 'Failed to reschedule appointment'));
      }
    });
  }
}
