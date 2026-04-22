import 'package:doctor_dashboard/features/message/bloc/messages_bloc.dart';
import 'package:doctor_dashboard/features/message/bloc/messages_state.dart';
import 'package:doctor_dashboard/features/message/presentation/widgets/conversation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesBloc, MessagesState>(
      builder: (context, state) {
        if (state is MessagesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MessagesError) {
          return Center(
            child: Text(state.message, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          );
        }

        if (state is MessagesLoaded && state.conversations.isEmpty) {
          return const Center(
            child: Text(
              'No conversations found',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF6B7280)),
            ),
          );
        }

        if (state is MessagesLoaded) {
          final conversations = state.conversations;

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: conversations.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              return ConversationCard(conversation: conversation);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
