import 'package:flutter/material.dart';

class StylesUtil {
  static TextStyle _baseStyle(
    FontWeight weight,
    double size, [
    Color? color = Colors.black,
  ]) {
    return TextStyle(
      color: color ?? Colors.black,
      fontSize: size,
      fontWeight: weight,
    );
  }

  static TextStyle w400(double size, [Color? color]) {
    return _baseStyle(FontWeight.w400, size, color);
  }

  static TextStyle w500(double size, [Color? color]) {
    return _baseStyle(FontWeight.w500, size, color);
  }

  static TextStyle w700(double size, [Color? color]) {
    return _baseStyle(FontWeight.w700, size, color);
  }
}
