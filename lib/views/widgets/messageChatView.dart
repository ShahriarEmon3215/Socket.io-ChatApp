import 'package:flutter/material.dart';
import '../../models/message.dart';
import 'message_item_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageChatView extends StatelessWidget {
  const MessageChatView(
      {super.key, required this.socket, required this.messages});

  final IO.Socket socket;
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 9,
        child: Container(
          child: ListView.builder(
            itemCount: messages.length,
            reverse: true,
            itemBuilder: (context, index) {
            //  var msg = messages[index];
               final reversedIndex = messages.length - 1 - index;
              final msg = messages[reversedIndex];
              return MessageBubble(
                text: msg.text,
                user: msg.user,
                time: msg.time,
                socket: socket,
              );
            },
          ),
        ));
  }
}
