import 'package:flutter/material.dart';

class AdminPrimaryButton extends StatelessWidget {
  const AdminPrimaryButton({super.key, required this.onPressed, required this.isLoading});

  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
              )
            : const Icon(Icons.login_rounded, size: 20),
        label: Text(
          isLoading ? 'Logging in...' : 'Login',
          style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B7A75),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }
}
