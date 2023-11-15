import 'package:flutter/material.dart';
import 'package:flutter_ia_chat/core/app/utils/screen_size_util.dart';
import 'package:flutter_ia_chat/core/app/utils/styles_util.dart';
import 'package:flutter_ia_chat/modules/chat/data/models/message_data_model.dart';
import 'package:flutter_ia_chat/modules/chat/presentation/chat_bot/widgets/border_icon_widget.dart';
import 'package:flutter_ia_chat/modules/chat/presentation/chat_bot/widgets/message_widget.dart';
import 'package:provider/provider.dart';

import '../providers/chat_bot_provider.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final bot = Provider.of<ChatBotProvider>(context);
    final screen = ScreenSizeUtil.of(context);
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      ),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.grey[50],
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: bot.isLoading ? Colors.grey[50] : Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: TextField(
                      enabled: !bot.isLoading,
                      controller: _inputController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintStyle: StylesUtil.w400(14, Colors.grey),
                        alignLabelWithHint: true,
                        hintText: 'Escribe tu mensaje',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]!),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: Colors.grey[300]!,
                          ),
                        ),
                      ),
                      onSubmitted: (value) {
                        bot.getMessage(value);
                        _inputController.clear();
                        setState(() {});
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent +
                              screen.hp(0.1),
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.linear,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    if (_inputController.text.isEmpty) return;
                    bot.getMessage(_inputController.text);
                    _inputController.clear();
                    setState(() {});
                  },
                  child: const BorderIconWidget(
                    icon: Icons.send,
                    iconColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: 16,
                  ),
                )
              ],
            ),
          )
        ],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 64,
          title: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const _BotImage(size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Partner Medical',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StylesUtil.w700(14, Colors.grey[800]),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 78, 210, 83),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'En linea',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: StylesUtil.w400(12, Colors.grey[800]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  ...List.generate(
                    bot.messages.length,
                    (x) {
                      final msg = bot.messages[x];
                      final isUserMessage = msg.type == MessageType.user;
                      final color =
                          !isUserMessage ? Colors.grey[100] : Colors.blue[50];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Row(
                          crossAxisAlignment: isUserMessage
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          mainAxisAlignment: isUserMessage
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (!isUserMessage) ...[
                              const Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: _BotImage(size: 24),
                              ),
                              const SizedBox(width: 8),
                            ],
                            MessageWidget(
                              msg: msg.message,
                              backgroundColor: color!,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  if (bot.isLoading) ...[
                    const Row(
                      children: [
                        _BotImage(size: 24),
                        SizedBox(width: 16),
                        SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BotImage extends StatelessWidget {
  final double size;
  const _BotImage({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        'assets/images/bot_image.png',
        fit: BoxFit.fitHeight,
        height: size,
        width: size,
      ),
    );
  }
}
