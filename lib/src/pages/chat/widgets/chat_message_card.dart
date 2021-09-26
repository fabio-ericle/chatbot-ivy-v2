import 'package:app_ivy_v2/src/model/chat_model.dart';
import 'package:flutter/material.dart';

class ChatMessageCard extends StatelessWidget {
  final ChatMessage? chatMessage;

  const ChatMessageCard({Key? key, this.chatMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chatMessage!.type == ChatMessageType.send
        ? _showSendMessage(context)
        : _showReceiveMessage();
  }

  Widget _showSendMessage(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 30.0,
      width: size.width * 0.75,
      padding: const EdgeInsets.all(5),
      margin:
          const EdgeInsets.only(left: 40.0, right: 15.0, top: 5.0, bottom: 5.0),
      color: Colors.blueGrey,
      child: Text(
        "${chatMessage!.text}",
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _showReceiveMessage() {
    return Container(
      height: 25,
      width: 100,
      padding: const EdgeInsets.all(5),
      margin:
          const EdgeInsets.only(right: 40.0, left: 15.0, top: 5.0, bottom: 5.0),
      color: Colors.blueGrey,
      child: Text(
        "${chatMessage!.text}",
        textAlign: TextAlign.left,
      ),
    );
  }
}
