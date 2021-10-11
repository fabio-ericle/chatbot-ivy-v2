enum ChatMessageType { send, receiveText, receiveImage, receiveOption }

class ChatMessage {
  final String? name;
  final String? text;
  final String? src;
  Map<String, dynamic>? option;
  final ChatMessageType type;

  ChatMessage(
      {this.name,
      this.text,
      this.src,
      this.option,
      this.type = ChatMessageType.send});
}
