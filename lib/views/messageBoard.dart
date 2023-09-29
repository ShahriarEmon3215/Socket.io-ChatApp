import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/controllers/message_controller.dart';
import '/views/widgets/messageChatView.dart';
import '/views/widgets/messageSendField.dart';

class MyHomePage extends ConsumerWidget {
  MyHomePage();

  var txtController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("Socket Chat"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) {
                var state = ref.watch(messageProvider);
                if (state is MessageLoadedState) {
                  return MessageChatView(
                    socket: state.socket!,
                    messages: state.messageList,
                  );
                }
                return Expanded(child: Text("No data"));
              },
            ),
            MessageSendField(
              txtController: txtController,
              socket: ref.read(messageProvider.notifier).socket!,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
