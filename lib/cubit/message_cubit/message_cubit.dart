import 'package:bloc/bloc.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../constants/constants.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageStates> {
  MessageCubit() : super(MessageInitial());
  List<Message> messageList =[];

  CollectionReference messages =
      FirebaseFirestore.instance.collection(ConstString.kMessagesCollections);

  void sendMessage({required String message, required String email}) async {
    try {
      messages.add(
        {
          ConstString.kMessage: message,
          ConstString.kCreatedAt: DateTime.now(),
          'id': email
        },
      );
    } on Exception catch (e) {
    }
  }

  void getMessage() {
    messages
        .orderBy(ConstString.kCreatedAt, descending: true)
        .snapshots()
        .listen((event) {
          messageList.clear();
          for(var doc in event.docs){
            messageList.add(Message.fromJson(doc));
          }
      emit(MessageSuccess(message: messageList));
    });
  }
}
