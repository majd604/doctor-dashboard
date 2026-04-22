// ignore_for_file: deprecated_member_use

import 'package:doctor_dashboard/features/message/bloc/messages_bloc.dart';
import 'package:doctor_dashboard/features/message/bloc/messages_event.dart';
import 'package:doctor_dashboard/features/message/data/services/message_service.dart';
import 'package:doctor_dashboard/features/message/presentation/widgets/messages_header.dart';
import 'package:doctor_dashboard/features/message/presentation/widgets/messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MessagesBloc(messageService: MessageService())..add(LoadAllConversations()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FB),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              MessagesHeader(),
              SizedBox(height: 24),
              Expanded(child: MessagesList()),
            ],
          ),
        ),
      ),
    );
  }
}
