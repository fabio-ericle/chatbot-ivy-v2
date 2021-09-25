import 'package:app_ivy_v2/src/model/chat_model.dart';
import 'package:flutter/material.dart';

class ChatMessageCard extends StatelessWidget {
  final ChatMessage? chatMessage;

  const ChatMessageCard({Key? key, this.chatMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chatMessage!.type == ChatMessageType.send
        ? _showSendMessage()
        : _showReceiveMessage();
  }

  Widget _showSendMessage() {
    return Container(
      height: 20,
      width: 100,
      color: Colors.blueGrey,
      child: const Text("Teste"),
    );
  }

  Widget _showReceiveMessage() {
    return Container(
      height: 20,
      width: 100,
      color: Colors.blueGrey,
      child: const Text("Teste"),
    );
  }
}
