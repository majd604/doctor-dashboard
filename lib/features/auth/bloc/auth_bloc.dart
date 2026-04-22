import 'package:doctor_dashboard/features/auth/bloc/auth_event.dart';
import 'package:doctor_dashboard/features/auth/bloc/auth_state.dart';
import 'package:doctor_dashboard/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AdminLoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.loginAdmin(email: event.email, password: event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError(message: 'Wrong email or password'));
      }
    });
  }
}
