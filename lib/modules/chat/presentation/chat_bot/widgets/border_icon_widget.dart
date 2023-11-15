import 'package:flutter/material.dart';

class BorderIconWidget extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final double padding;
  final double iconSize;
  final bool hideBorder;
  const BorderIconWidget({
    super.key,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.padding = 4,
    this.iconSize = 16,
    this.hideBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: hideBorder
            ? null
            : Border.all(
                color: Colors.grey,
              ),
      ),
      child: Icon(
        icon,
        color: iconColor ?? Colors.grey[500],
        size: iconSize,
      ),
    );
  }
}
