import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageSendField extends StatelessWidget {
  const MessageSendField({
    super.key,
    required this.txtController,
    required this.socket,
  });

  final TextEditingController txtController;
  final IO.Socket socket;

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
                txtController.clear();
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

  void sendMessage() {
    socket.emit('message', {
      'user': socket.id,
      'text': txtController.text,
      "time": DateTime.now().toString()
    });
  }
}
