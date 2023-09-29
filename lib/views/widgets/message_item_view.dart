import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.socket,
      required this.text,
      required this.user,
      required this.time})
      : super(key: key);

  final user;
  final text;
  final time;
  final socket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: user == socket.id
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('dd MMM yyy   hh:mm a').format(DateTime.parse(time)),
            style: TextStyle(fontSize: 10, color: Colors.white60),
          ),
          Material(
            color: user == socket.id ? Colors.blue : Colors.white70,
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
