enum MessageType { bot, user }

class MessageDataModel {
  final String message;
  final MessageType type;

  const MessageDataModel({required this.message, required this.type});
}
