import 'package:flutter_ia_chat/services/base_service.dart';

class BotService extends BaseService {
  Future<String?> getBotMessage(String prompt) async {
    final body = {
      'message': prompt,
    };
    return await api.post<String>(
      url: 'https://django-ia-f08bd00b5c25.herokuapp.com/api/conversation/',
      body: body,
      mapper: (data) => data['message'],
    );
  }
}
