
import 'package:chat_app/constants/constants.dart';

class Message {
  final String message;
  final String id;
  Message(this.message, this.id);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[ConstString.kMessage], jsonData['id']);
  }
}
