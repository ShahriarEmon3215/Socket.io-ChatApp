import 'dart:async';

import 'package:socket_chat_app/models/message.dart';

class StreamSocket {
  final _socketResponse = StreamController<List<Message>>();

   get addResponse => _socketResponse.sink.add;

  Stream<List<Message>> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
