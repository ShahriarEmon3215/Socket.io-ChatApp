import 'package:flutter/material.dart';
import 'package:socket_chat_app/controllers/message_controller.dart';
import '../../models/message.dart';
import 'message_item_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageChatView extends StatelessWidget {
  const MessageChatView(
      {super.key, required this.socket, required this.messages, required this.controller});

  final IO.Socket socket;
  final List<Message> messages;
  final MessageNotifier controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 9,
        child: Container(
            child: StreamBuilder(
          stream: controller.streamSocket.getResponse,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                   // itemCount: messages.length,
                   itemCount: snapshot.data!.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      /*  var msg = messages[index]; */

                      // final reversedIndex = messages.length - 1 - index;
                      // final msg = messages[reversedIndex];
                      final reversedIndex = snapshot.data!.length - 1 - index;
                      final msg = snapshot.data![reversedIndex];
                      
                      return MessageBubble(
                        text: msg.text,
                        user: msg.user,
                        time: msg.time,
                        socket: socket,
                      );
                    },
                  )
                : SizedBox();
          },
        )));
  }
}
