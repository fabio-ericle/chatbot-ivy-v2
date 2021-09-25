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
  final TextEditingController _controllerText = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerText.addListener(() {});
  }

  @override
  void dispose() {
    _controllerText.dispose();
    super.dispose();
  }

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
        children: [_buildList(), _buildUserInput()],
      ),
    );
  }

  void _addMessage({required String text, required ChatMessageType type}) {
    var message = ChatMessage(text: text, type: type);
    setState(() {
      _messageCard.insert(0, message);
    });
  }

  void _sendMessage({required String text}) {
    _addMessage(text: text, type: ChatMessageType.send);
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

  Widget _buildTextField() {
    return Flexible(
        child: Container(
      padding: const EdgeInsets.only(left: 5, right: 20),
      child: TextField(
        controller: _controllerText,
        decoration: const InputDecoration(
          hintText: "mensagem",
          border: InputBorder.none,
        ),
      ),
    ));
  }

  Widget _buildSendButton() {
    return Container(
      margin: const EdgeInsets.only(left: 8.0),
      child: IconButton(
        onPressed: () {
          _sendMessage(text: _controllerText.text);
        },
        icon: const Icon(
          Icons.send,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildUserInput() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: Row(
        children: [
          _buildTextField(),
          _buildSendButton(),
        ],
      ),
    );
  }
}
