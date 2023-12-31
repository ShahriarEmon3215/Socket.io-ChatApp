import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import '../models/message.dart';
import '../models/stream.dart';

final messageProvider =
    ChangeNotifierProvider<MessageNotifier>((ref) => MessageNotifier());

class MessageNotifier extends ChangeNotifier {
  MessageNotifier();
  IO.Socket? socket;
  StreamSocket streamSocket = StreamSocket();
  String socketUrl = "";
  List<Message> messagesList = [];
  late PusherChannelsFlutter pusher;
  var chatChannel;
  var socket_Id;

  connectAndfetchMessage() async {
    // socketUrl = !kIsWeb ? 'http://10.0.2.2:2023' : "http://localhost:2023";
    // socket = IO.io(
    //     socketUrl,
    //     OptionBuilder()
    //         .setTransports(['websocket']) // for Flutter or Dart VM
    //         .disableAutoConnect() // disable auto-connection
    //         .setExtraHeaders({'foo': 'bar'}) // optional
    //         .build());
    // socket!.connect();

    // socket!.on("broadcast", (data) {
    //   messagesList.add(Message.fromJson(data));
    //   streamSocket.addResponse(messagesList);
    //   notifyListeners();
    // });
    pusher = PusherChannelsFlutter.getInstance();
    await pusher.init(
        apiKey: "a8c22b14a31ad1b20bb1",
        cluster: "ap1",
        onEvent: (event) {
          // print("Got event: $event");
        });
    await pusher.connect();

    chatChannel = await pusher.subscribe(
        channelName: "chat-channel",
        onEvent: (event) {
          if (json.decode(event.data)['user'] != null) {
            messagesList.add(Message.fromJson(json.decode(event.data)));
            notifyListeners();
          }

          print(messagesList.length);
        });
  }
}
