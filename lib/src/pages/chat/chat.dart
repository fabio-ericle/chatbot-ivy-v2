import 'package:app_ivy_v2/src/model/chat_model.dart';
import 'package:flutter/material.dart';

import 'widgets/chat_message_card.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageCard = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          _buildList(),
        ],
      ),
    );
  }

  Widget _buildList() {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.all(2),
        itemCount: _messageCard.length,
        itemBuilder: (_, int index) {
          return ChatMessageCard(
            chatMessage: _messageCard[index],
          );
        },
      ),
    );
  }
}
