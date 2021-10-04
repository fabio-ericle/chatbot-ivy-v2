import 'package:app_ivy_v2/src/model/chat_model.dart';
import 'package:app_ivy_v2/src/service/config.dart';
import 'package:app_ivy_v2/src/service/watson_assistant.dart';
import 'package:flutter/material.dart';
import 'widgets/chat_message_card.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageList = <ChatMessage>[];
  final TextEditingController _controllerText = TextEditingController();
  String? _text;

  @override
  void initState() {
    super.initState();
    _controllerText.addListener(() {});
    watsonAssistant = WatsonAssistantApiV2(
        watsonAssistantV2Credential: watsonAssistantV2Credential);
  }

  @override
  void dispose() {
    _controllerText.dispose();
    super.dispose();
  }

  WatsonAssistantV2Credential watsonAssistantV2Credential = credential;
  late WatsonAssistantApiV2 watsonAssistant;
  late WatsonAssistantResponse watsonAssistantResponse;
  WatsonAssitantContext watsonAssitantContext =
      WatsonAssitantContext(context: {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _messageList.clear();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          _buildList(),
          _buildUserInput(),
        ],
      ),
    );
  }

  void _addMessage({required String text, required ChatMessageType type}) {
    var message = ChatMessage(text: text, type: type);
    setState(() {
      _messageList.insert(0, message);
    });

    if (type == ChatMessageType.send) {
      setState(() {
        _callWatsonAssistant(text: _controllerText.text);
      });
    }
  }

  void _sendMessage({required String text}) {
    _addMessage(text: text, type: ChatMessageType.send);
    _controllerText.clear();
  }

  Widget _buildList() {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.all(2),
        itemCount: _messageList.length,
        itemBuilder: (_, int index) {
          return ChatMessageCard(
            chatMessage: _messageList[index],
          );
        },
        reverse: true,
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
          if (_controllerText.text.isNotEmpty) {
            _sendMessage(text: _controllerText.text);
          }
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

  Future<void> _callWatsonAssistant({required String text}) async {
    _addMessage(text: 'Escrevendo...', type: ChatMessageType.receiveText);
    watsonAssistantResponse = await watsonAssistant.sendMessage(
        textInput: text, watsonAssitantContext: watsonAssitantContext);
    setState(() {
      _text = watsonAssistantResponse.responseText;
      _messageList.removeAt(0);
    });

    print('Text: ${watsonAssistantResponse.responseText}');
    print('Image: ${watsonAssistantResponse.responseImage}');
    print('Option: ${watsonAssistantResponse.responseOptions}');

    _addMessage(
        text: _text != null ? _text! : '', type: ChatMessageType.receiveText);

    //watsonAssitantContext = watsonAssistantResponse.context!;
  }
}
