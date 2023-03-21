part of 'message_cubit.dart';

@immutable
abstract class MessageStates {}

class MessageInitial extends MessageStates {}

class MessageSuccess extends MessageStates {
  List<Message> message;
  MessageSuccess({required this.message});
}


