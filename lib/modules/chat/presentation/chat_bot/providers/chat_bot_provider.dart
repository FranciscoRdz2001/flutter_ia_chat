import 'package:flutter/widgets.dart';
import 'package:flutter_ia_chat/modules/chat/data/models/message_data_model.dart';
import 'package:flutter_ia_chat/services/bot_service/bot_service.dart';

class ChatBotProvider extends ChangeNotifier {
  static final _service = BotService();

  final List<MessageDataModel> _messages = [];
  bool _isLoading = false;

  List<MessageDataModel> get messages => _messages;

  void addMessage(String message, MessageType type) {
    final msg = MessageDataModel(message: message, type: type);
    _messages.add(msg);
    notifyListeners();
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> getMessage(String prompt) async {
    isLoading = true;
    addMessage(prompt, MessageType.user);
    final msg = await _service.getBotMessage(prompt);
    if (msg != null) addMessage(msg, MessageType.bot);
    isLoading = false;
  }
}
