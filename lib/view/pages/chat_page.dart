import 'package:chat_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/message.dart';
import '../component/chat_buble.dart';
import '../component/show_snack_bar.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final _controller = ScrollController();
  var email;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(ConstString.kMessagesCollections);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages
          .orderBy(ConstString.kCreatedAt, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ConstColors.kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(2), // Border radius
                      child: ClipOval(
                        child: Image.asset(
                          ConstAssets.chatRoomIcon,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Chat Room',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'pacifico',
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBuble(
                                message: messagesList[index],
                              )
                            : ChatBubleForFriend(message: messagesList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      sendMessage(data, context);
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          sendMessage(controller.text, context);
                        },
                        child: Icon(
                          Icons.send,
                          color: ConstColors.kPrimaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: ConstColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ConstColors.kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ConstAssets.kLogo,
                    height: 50,
                  ),
                  Text('chat'),
                ],
              ),
              centerTitle: true,
            ),
            body: Center(child: Text('Loading...')),
          );
        }
      },
    );
  }

  void sendMessage(String data, BuildContext context) {
    if (data.isEmpty) {
      showSnackBar(context, 'can\'t sent empty text');
    } else {
      messages.add(
        {
          ConstString.kMessage: data,
          ConstString.kCreatedAt: DateTime.now(),
          'id': email
        },
      );
      controller.clear();
      _controller.animateTo(0,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }
}
