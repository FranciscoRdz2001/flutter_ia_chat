import 'package:flutter/material.dart';
import 'package:flutter_ia_chat/modules/chat/presentation/chat_bot_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat bot',
      home: ChatBotPage(),
    );
  }
}
