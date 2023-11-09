import 'package:flutter/material.dart';
import 'package:flutter_ia_chat/core/app/utils/screen_size_util.dart';
import 'package:flutter_ia_chat/core/app/utils/styles_util.dart';
import 'package:flutter_ia_chat/modules/chat/data/mock/mock_data.dart';
import 'package:flutter_ia_chat/modules/chat/presentation/widgets/border_icon_widget.dart';
import 'package:flutter_ia_chat/modules/chat/presentation/widgets/message_widget.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final MockData _data = MockData();
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _data.onRefreshData = () {
        setState(() {});
      };
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      color: _data.isLoading ? Colors.grey[50] : Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: TextField(
                      enabled: !_data.isLoading,
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
                        _data.addMessage(value);
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
                    _data.addMessage(_inputController.text);
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
                  const BorderIconWidget(
                    icon: Icons.arrow_back,
                  ),
                  SizedBox(width: screen.wp(0.05)),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue[50],
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.blue[500],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FitBot',
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
                  SizedBox(width: screen.wp(0.05)),
                  const BorderIconWidget(
                    icon: Icons.more_horiz,
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
                    _data.messages.length,
                    (x) {
                      final msg = _data.messages[x];
                      final isUserMessage = (x % 2) == 0;
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
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: BorderIconWidget(
                                  icon: Icons.person,
                                  iconColor: Colors.blue,
                                  backgroundColor: Colors.blue[50],
                                  hideBorder: true,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            MessageWidget(
                              msg: msg,
                              backgroundColor: color!,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  if (_data.isLoading) ...[
                    Row(
                      children: [
                        BorderIconWidget(
                          icon: Icons.person,
                          iconColor: Colors.blue,
                          backgroundColor: Colors.blue[50],
                          hideBorder: true,
                        ),
                        const SizedBox(width: 16),
                        const SizedBox(
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
