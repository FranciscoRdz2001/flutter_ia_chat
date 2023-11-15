import 'package:flutter/material.dart';

class ScreenSizeUtil {
  double height;
  double width;
  ScreenSizeUtil({
    required this.height,
    required this.width,
  });

  factory ScreenSizeUtil.of(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScreenSizeUtil(
      height: size.height,
      width: size.width,
    );
  }

  double hp(double percent) => height * percent;
  double wp(double percent) => width * percent;
}
