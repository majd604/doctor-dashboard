// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/core/dialog/app_dialog.dart';
import 'package:doctor_dashboard/core/helpers/app_snackbar.dart';
import 'package:doctor_dashboard/features/message/bloc/messages_bloc.dart';
import 'package:doctor_dashboard/features/message/bloc/messages_event.dart';
import 'package:doctor_dashboard/features/message/data/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationDeleteButton extends StatelessWidget {
  const ConversationDeleteButton({super.key, required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async {
        final confirm = await AppDialog.showDeleteDialog(
          context: context,
          title: 'Delete Conversation',
          message: 'Are you sure you want to delete this conversation?',
        );

        if (confirm == true && context.mounted) {
          await MessageService().deleteConversation(conversationId);

          if (!context.mounted) return;

          context.read<MessagesBloc>().add(LoadAllConversations());
          AppSnackbar.showSuccess(context, 'Conversation deleted');
        }
      },
      child: Container(
        height: 46,
        width: 46,
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withOpacity(0.10),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444), size: 22),
      ),
    );
  }
}
