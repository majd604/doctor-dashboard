import 'package:doctor_dashboard/core/dialog/app_dialog.dart';
import 'package:doctor_dashboard/core/dialog/reschedule_appointment_dialog.dart';
import 'package:doctor_dashboard/core/helpers/app_snackbar.dart';
import 'package:doctor_dashboard/features/appointment/bloc/appointment_bloc.dart';
import 'package:doctor_dashboard/features/appointment/bloc/appointment_event.dart';
import 'package:doctor_dashboard/features/appointment/data/model/appointment_model.dart';
import 'package:doctor_dashboard/features/appointment/presentation/widgets/appointment_action_button.dart';
import 'package:doctor_dashboard/features/message/data/models/conversation_model.dart';
import 'package:doctor_dashboard/features/message/presentation/screens/dashboard_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentActionsRow extends StatelessWidget {
  const AppointmentActionsRow({super.key, required this.appointment});

  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppointmentActionButton(
          icon: Icons.chat_bubble_outline_rounded,
          color: const Color(0xFF6366F1),
          tooltip: 'Open chat',
          onTap: () async {
            final conversationId = '${appointment.userId}_${appointment.doctorId}';

            final conversation = ConversationModel(
              id: conversationId,
              userId: appointment.userId,
              userName: appointment.patientName,
              doctorId: appointment.doctorId,
              doctorName: appointment.doctorName,
              doctorImageUrl: appointment.doctorImageUrl,
              lastMessage: '',
              lastMessageTime: DateTime.now(),
              lastSenderId: '',
              createdAt: appointment.createdAt,
            );

            if (!context.mounted) return;

            Navigator.push(context, MaterialPageRoute(builder: (_) => DashboardChatScreen(conversation: conversation)));
          },
        ),
        const SizedBox(width: 10),
        AppointmentActionButton(
          icon: Icons.edit_calendar_outlined,
          color: const Color(0xFFF59E0B),
          tooltip: 'Reschedule',
          onTap: () async {
            final result = await showDialog(
              context: context,
              builder: (_) => RescheduleAppointmentDialog(initialDate: appointment.date, initialTime: appointment.time),
            );
            if (result != null && context.mounted) {
              context.read<AppointmentBloc>().add(
                RescheduleAppointment(appointmentId: appointment.id, newDate: result['date'], newTime: result['time']),
              );
            }
          },
        ),
        const SizedBox(width: 10),
        AppointmentActionButton(
          icon: Icons.delete_outline_rounded,
          color: const Color(0xFFEF4444),
          tooltip: 'Delete',
          onTap: () async {
            final confirm = await AppDialog.showDeleteDialog(context: context);

            if (confirm == true && context.mounted) {
              context.read<AppointmentBloc>().add(DeleteAppointment(appointmentId: appointment.id));

              AppSnackbar.showSuccess(context, 'Appointment deleted');
            }
          },
        ),
      ],
    );
  }
}
