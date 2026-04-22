import 'package:doctor_dashboard/features/message/data/models/conversation_model.dart';
import 'package:equatable/equatable.dart';

abstract class MessagesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<ConversationModel> conversations;

  MessagesLoaded({required this.conversations});

  @override
  List<Object?> get props => [conversations];
}

class MessagesError extends MessagesState {
  final String message;

  MessagesError({required this.message});

  @override
  List<Object?> get props => [message];
}
