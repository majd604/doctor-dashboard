import 'package:equatable/equatable.dart';

abstract class MessagesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAllConversations extends MessagesEvent {}
