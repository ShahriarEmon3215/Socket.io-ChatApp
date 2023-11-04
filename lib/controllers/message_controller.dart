import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import '../models/message.dart';
import '../models/stream.dart';

final messageProvider = ChangeNotifierProvider.autoDispose<MessageNotifier>(
    (ref) => MessageNotifier());

class MessageNotifier extends ChangeNotifier {
  MessageNotifier();
  IO.Socket? socket;
  StreamSocket streamSocket = StreamSocket();
  String socketUrl = "";
  List<Message> messagesList = [];

  connectAndfetchMessage() {
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
      messagesList.add(Message.fromJson(data));
      streamSocket.addResponse(messagesList);
      notifyListeners();
    });
  }
}
