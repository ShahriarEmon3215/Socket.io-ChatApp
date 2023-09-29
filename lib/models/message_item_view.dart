import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.socket,
    required this.text,
    required this.user
  }) : super(key: key);

  final user;
  final text;
  final socket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            user == socket.id ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Text(socket.id),
          Material(
            color: user == socket.id ? Colors.blue : Colors.green,
            borderRadius: user == socket.id
                ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(
                      15,
                    ),
                    bottomRight: Radius.circular(15))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(
                      15,
                    ),
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15)),
            child: Container(
                margin: EdgeInsets.all(8),
                child: Text(
                  text,
                  style: TextStyle(
                    color: user == socket.id ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
