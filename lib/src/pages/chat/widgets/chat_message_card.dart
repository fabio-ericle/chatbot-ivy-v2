import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:app_ivy_v2/src/model/chat_model.dart';

class ChatMessageCard extends StatelessWidget {
  final ChatMessage? chatMessage;
  final Future<void>? onClick;

  const ChatMessageCard({
    Key? key,
    this.chatMessage,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chatMessage!.type == ChatMessageType.send
        ? _showSendMessage(context)
        : chatMessage!.type == ChatMessageType.receiveText
            ? _showReceivedMessage(context)
            : chatMessage!.type == ChatMessageType.receiveOption
                ? _showReceivedMessageOptions(context)
                : _showMessageReceivedImage(context);
  }

  Widget _showSendMessage(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.75,
      padding: const EdgeInsets.all(5),
      margin:
          const EdgeInsets.only(left: 40.0, right: 15.0, top: 5.0, bottom: 5.0),
      color: Colors.blueGrey,
      child: Text(
        "${chatMessage!.text}",
        style: const TextStyle(fontSize: 20.0, color: Colors.white),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _showReceivedMessage(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.75,
      padding: const EdgeInsets.all(5),
      margin:
          const EdgeInsets.only(right: 40.0, left: 15.0, top: 5.0, bottom: 5.0),
      color: Colors.blueGrey,
      child: SizedBox(
        child: Text(
          "${chatMessage!.text}",
          style: const TextStyle(fontSize: 20.0, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _showReceivedMessageOptions(BuildContext context) {
    int count =
        jsonEncode(chatMessage!.option!['options']).split('label').length;
    // print(count);
    return Container(
      margin:
          const EdgeInsets.only(left: 20.0, right: 40.0, top: 5.0, bottom: 5.0),
      width: 150.0,
      child: SizedBox(
        child: Column(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(5),
              shrinkWrap: true,
              itemCount: count - 1,
              itemBuilder: (context, int index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    height: 30.0,
                    width: double.infinity,
                    color: Colors.blue,
                    child: Text(
                      "${chatMessage!.option!['options'][index]['label']}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _showMessageReceivedImage(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: chatMessage!.image == null
          ? Image.network(chatMessage!.image!['src'])
          : Container(),
    );
  }
}
