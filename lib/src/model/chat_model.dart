enum ChatMessageType { send, receiveText, receiveImage, receiveOption }

class ChatMessage {
  final String? name;
  final String? text;
  final Map<String, dynamic>? image;
  final Map<String, dynamic>? option;
  final ChatMessageType type;

  ChatMessage({
    this.name,
    this.text,
    this.image,
    this.option,
    this.type = ChatMessageType.send,
  });
}
