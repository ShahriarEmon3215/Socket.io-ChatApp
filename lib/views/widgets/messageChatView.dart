import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_chat_app/controllers/message_controller.dart';
import '../../models/message.dart';
import 'message_item_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageChatView extends ConsumerWidget {
  const MessageChatView(
      {super.key, required this.messages, required this.controller});

  //final IO.Socket socket;
  final List<Message> messages;
  final MessageNotifier controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(messageProvider);
    return Expanded(
        flex: 9,
        child: Container(
            child: ListView.builder(
          // itemCount: messages.length,
          itemCount: messages.length,
          reverse: true,
          itemBuilder: (context, index) {
            /*  var msg = messages[index]; */

            // final reversedIndex = messages.length - 1 - index;
            // final msg = messages[reversedIndex];
            final reversedIndex = messages.length - 1 - index;
            final msg = messages[reversedIndex];

            return MessageBubble(
              text: msg.text,
              user: msg.user,
              time: msg.time,
            );
          },
        )));
  }
}
