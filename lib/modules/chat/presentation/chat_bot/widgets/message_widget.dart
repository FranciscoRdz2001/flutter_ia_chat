import 'package:flutter/material.dart';
import 'package:flutter_ia_chat/core/app/utils/screen_size_util.dart';
import 'package:flutter_ia_chat/core/app/utils/styles_util.dart';

class MessageWidget extends StatefulWidget {
  final Color backgroundColor;
  final String msg;
  const MessageWidget({
    super.key,
    required this.backgroundColor,
    required this.msg,
  });

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!animate) {
        setState(() {
          animate = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = ScreenSizeUtil.of(context);
    return AnimatedOpacity(
      opacity: animate ? 1 : 0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastEaseInToSlowEaseOut,
      child: AnimatedScale(
        curve: Curves.fastEaseInToSlowEaseOut,
        scale: animate ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          constraints: BoxConstraints(maxWidth: screen.wp(0.5)),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            color: widget.backgroundColor,
          ),
          child: Text(
            widget.msg,
            style: StylesUtil.w400(12, Colors.grey[800]),
          ),
        ),
      ),
    );
  }
}
