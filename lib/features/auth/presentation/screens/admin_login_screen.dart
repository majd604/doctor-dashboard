// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/features/auth/bloc/auth_bloc.dart';
import 'package:doctor_dashboard/features/auth/bloc/auth_event.dart';
import 'package:doctor_dashboard/features/auth/bloc/auth_state.dart';
import 'package:doctor_dashboard/features/auth/data/repositories/auth_repository.dart';
import 'package:doctor_dashboard/features/auth/presentation/widgets/admin_login_form.dart';
import 'package:doctor_dashboard/features/auth/presentation/widgets/admin_login_header.dart';
import 'package:doctor_dashboard/core/helpers/app_snackbar.dart';
import 'package:doctor_dashboard/features/dashboard/presentation/screens/dashboard_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onLoginPressed(BuildContext context) {
    if (!formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      AdminLoginRequested(email: emailController.text.trim(), password: passwordController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authRepository: AuthRepository()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            AppSnackbar.showError(context, state.message.replaceFirst('Exception: ', ''));
          }

          if (state is AuthSuccess) {
            AppSnackbar.showSuccess(context, 'Login successful');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardHomeScreen()));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            backgroundColor: const Color(0xFFF6F8FB),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Container(
                    padding: const EdgeInsets.all(36),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 18, offset: const Offset(0, 8)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AdminLoginHeader(),
                        const SizedBox(height: 28),
                        AdminLoginForm(
                          formKey: formKey,
                          emailController: emailController,
                          passwordController: passwordController,
                          isLoading: isLoading,
                          onPressed: () => onLoginPressed(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
