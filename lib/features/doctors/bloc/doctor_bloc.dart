import 'package:doctor_dashboard/features/doctors/bloc/doctor_event.dart';
import 'package:doctor_dashboard/features/doctors/bloc/doctor_state.dart';
import 'package:doctor_dashboard/features/doctors/data/services/doctor_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorService doctorService;

  DoctorBloc({required this.doctorService}) : super(DoctorInitial()) {
    on<LoadDoctors>((event, emit) async {
      emit(DoctorLoading());
      try {
        final doctors = await doctorService.getDoctors();
        emit(DoctorLoaded(doctors: doctors));
      } catch (e) {
        emit(DoctorError(message: 'Failed to load doctors'));
      }
    });
  }
}
