import 'package:flutter/material.dart';

class MockData {
  final List<String> messages;

  VoidCallback? onRefreshData;
  bool isLoading = false;

  MockData({this.onRefreshData}) : messages = [];

  void addMessage(String message) {
    if (isLoading) return;
    messages.add(message);

    isLoading = true;
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      messages.add('¡Hola!, soy un bot.');
      isLoading = false;
      onRefreshData?.call();
    });
  }
}
