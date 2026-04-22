import 'package:doctor_dashboard/features/auth/presentation/widgets/admin_info_card.dart';
import 'package:doctor_dashboard/features/auth/presentation/widgets/admin_primary_button.dart';
import 'package:doctor_dashboard/features/auth/presentation/widgets/admin_text_field.dart';
import 'package:doctor_dashboard/core/helpers/app_validator.dart';
import 'package:flutter/material.dart';

class AdminLoginForm extends StatelessWidget {
  const AdminLoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.onPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AdminTextField(
            label: 'Email Address',
            hintText: 'Enter admin email',
            icon: Icons.email_outlined,
            obscureText: false,
            controller: emailController,
            validator: AppValidator.validateEmail,
          ),
          const SizedBox(height: 18),
          AdminTextField(
            label: 'Password',
            hintText: 'Enter password',
            icon: Icons.lock_outline_rounded,
            obscureText: true,
            controller: passwordController,
            validator: AppValidator.validatePassword,
          ),
          const SizedBox(height: 24),
          AdminPrimaryButton(isLoading: isLoading, onPressed: onPressed),
          const SizedBox(height: 18),
          const AdminInfoCard(),
        ],
      ),
    );
  }
}
