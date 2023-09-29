import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import '../models/message.dart';

final messageProvider =
    StateNotifierProvider.autoDispose<MessageNotifier, MessageState>(
        (ref) => MessageNotifier());

class MessageState {}

class MessageInitState extends MessageState {}

class MessageLoadingState extends MessageState {}

class MessageLoadedState extends MessageState {
  MessageLoadedState({required this.messageList, required this.socket});

  IO.Socket? socket;
  List<Message> messageList = [];
}

class MessageErrorState extends MessageState {
  MessageErrorState({required this.error});

  final String error;
}

class MessageNotifier extends StateNotifier<MessageState> {
  MessageNotifier() : super(MessageInitState()) {
    fetchMessage();
  }
  IO.Socket? socket;
  String socketUrl = "";

  List<Message> messagesList = [];

  fetchMessage() {
    socketUrl = !kIsWeb ? 'http://10.0.2.2:2023' : "http://localhost:2023";
    socket = IO.io(
        socketUrl,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket!.connect();

    socket!.on("broadcast", (data) {
      print(data);
      messagesList.add(Message.fromJson(data));
      state = MessageLoadedState(messageList: messagesList, socket: socket);
    });
  }
}
