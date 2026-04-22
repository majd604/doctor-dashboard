// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RescheduleAppointmentDialog extends StatefulWidget {
  const RescheduleAppointmentDialog({super.key, required this.initialDate, required this.initialTime});

  final DateTime initialDate;
  final String initialTime;

  @override
  State<RescheduleAppointmentDialog> createState() => _RescheduleAppointmentDialogState();
}

class _RescheduleAppointmentDialogState extends State<RescheduleAppointmentDialog> {
  late DateTime selectedDate;
  late TextEditingController timeController;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    timeController = TextEditingController(text: widget.initialTime);
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final now = DateTime.now();
    final firstAllowedDate = DateTime(now.year, now.month, now.day);

    final safeInitialDate = selectedDate.isBefore(firstAllowedDate) ? firstAllowedDate : selectedDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: safeInitialDate,
      firstDate: firstAllowedDate,
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _parseTime(widget.initialTime));

    if (picked != null) {
      final now = DateTime.now();
      final dateTime = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);

      timeController.text = DateFormat('hh:mm a').format(dateTime);
    }
  }

  TimeOfDay _parseTime(String value) {
    try {
      final date = DateFormat('hh:mm a').parse(value);
      return TimeOfDay(hour: date.hour, minute: date.minute);
    } catch (_) {
      return TimeOfDay.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat('dd MMM yyyy').format(selectedDate);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 18, offset: const Offset(0, 10)),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reschedule Appointment',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Update the appointment date and time.',
                  style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Date',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
                ),
                const SizedBox(height: 10),
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: pickDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, color: Color(0xFF0B7A75)),
                        const SizedBox(width: 12),
                        Text(dateText, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Time',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: timeController,
                  readOnly: true,
                  onTap: pickTime,
                  decoration: InputDecoration(
                    hintText: 'Select time',
                    prefixIcon: const Icon(Icons.access_time_rounded, color: Color(0xFF0B7A75)),
                    filled: true,
                    fillColor: const Color(0xFFF9FAFB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF0B7A75), width: 1.3),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, {'date': selectedDate, 'time': timeController.text.trim()});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0B7A75),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Save Changes'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
