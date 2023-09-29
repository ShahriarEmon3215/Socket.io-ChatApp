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
      flex: 1,
      child: Container(
        child: TextField(
          controller: txtController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(width: 2, color: Colors.white),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                socket.emit('message', {
                  'user': socket.id,
                  'text': txtController.text
                });
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
}
