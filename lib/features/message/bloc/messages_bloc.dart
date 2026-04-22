import 'package:doctor_dashboard/features/message/bloc/messages_event.dart';
import 'package:doctor_dashboard/features/message/bloc/messages_state.dart';
import 'package:doctor_dashboard/features/message/data/services/message_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final MessageService messageService;

  MessagesBloc({required this.messageService}) : super(MessagesInitial()) {
    on<LoadAllConversations>((event, emit) async {
      emit(MessagesLoading());
      try {
        final conversations = await messageService.getAllConversations();
        emit(MessagesLoaded(conversations: conversations));
      } catch (e) {
        emit(MessagesError(message: 'Failed to load conversations'));
      }
    });
  }
}
