import 'package:flutter/material.dart';

class AddDoctorSpecialtyDropdown extends StatelessWidget {
  const AddDoctorSpecialtyDropdown({super.key, required this.value, required this.onChanged, required this.items});

  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Specialty',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.medical_services_outlined, color: Color(0xFF0B7A75)),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFF0B7A75), width: 1.4),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select specialty';
            }
            return null;
          },
        ),
      ],
    );
  }
}
