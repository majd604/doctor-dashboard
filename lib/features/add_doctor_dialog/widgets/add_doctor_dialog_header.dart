import 'package:flutter/material.dart';

class AddDoctorDialogHeader extends StatelessWidget {
  const AddDoctorDialogHeader({super.key, required this.isEdit});
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 58,
          width: 58,
          decoration: BoxDecoration(color: const Color(0xFFE8F7F6), borderRadius: BorderRadius.circular(18)),
          child: isEdit
              ? const Icon(Icons.edit_outlined, color: Color(0xFF0B7A75), size: 28)
              : const Icon(Icons.person_add_alt_1_rounded, color: Color(0xFF0B7A75), size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEdit ? 'Edit Doctor' : 'Add New Doctor',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
              ),
              SizedBox(height: 6),
              Text(
                isEdit
                    ? 'Update doctor information and pricing details.'
                    : 'Enter doctor details to add them to the dashboard and mobile app.',
                style: TextStyle(fontSize: 14.5, height: 1.5, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded),
          color: const Color(0xFF6B7280),
        ),
      ],
    );
  }
}
