import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:socket_chat_app/controllers/message_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

import '../../main.dart';

class MessageSendField extends StatelessWidget {
  const MessageSendField({
    super.key,
    required this.txtController,
    // required this.socket,
    required this.controller,
  });

  final TextEditingController txtController;
  // final IO.Socket socket;
  final MessageNotifier controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        child: TextField(
          controller: txtController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Type...",
            hintStyle: TextStyle(color: Colors.white60),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(width: 2, color: Colors.white),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                sendMessage();
                // txtController.clear();
              },
              icon: Icon(
                Icons.send,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendMessage() async {
    print( me);
    // socket.emit('message', {
    //   'user': socket.id,
    //   'text': txtController.text,
    //   "time": DateTime.now().toString()
    // });

    // await controller.chatChannel.trigger(PusherEvent(
    //     channelName: "chat-channel",
    //     eventName: "message-event",
    //     userId: "1",
    //     data: {
    //       'user': "emon",
    //       'text': txtController.text,
    //       "time": DateTime.now().toString()
    //     }));asdfasdf
    var headers = {"Content-Type": "application/json"};
    var response = await http.post(
      Uri.parse('http://10.0.2.2:2023/api/message'),
      headers: headers,
      body: jsonEncode({
        'user': me,
        'text': txtController.text,
        "time": DateTime.now().toString()
      }),
    );

    txtController.clear();

    print(response.body);
  }
}
