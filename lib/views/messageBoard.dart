import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/controllers/message_controller.dart';
import '/views/widgets/messageChatView.dart';
import '/views/widgets/messageSendField.dart';

class MyHomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final txtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(messageProvider).connectAndfetchMessage();
  }

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(messageProvider);
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
            Builder(
              builder: (context) {
                //  if (controller.messagesList.isNotEmpty) {
                return MessageChatView(
                // socket: controller.socket!,
                  messages: controller.messagesList,
                  controller: controller,
                );
                //  }
                //return Expanded(flex: 9, child: Text("No data"));
              },
            ),
            SizedBox(height: 10),
            MessageSendField(
              txtController: txtController,
            //  socket: ref.read(messageProvider.notifier).socket!,
              controller: controller,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
