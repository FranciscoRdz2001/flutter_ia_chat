import 'package:flutter/material.dart';
import 'package:flutter_ia_chat/modules/chat/presentation/chat_bot/pages/chat_bot_page.dart';
import 'package:flutter_ia_chat/modules/chat/presentation/chat_bot/providers/chat_bot_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (context) => ChatBotProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat bot',
        home: ChatBotPage(),
      ),
    );
  }
}
