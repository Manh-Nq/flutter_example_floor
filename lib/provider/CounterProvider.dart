import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void plusCounter() {
    _count++;
    notifyListeners();
  }

  void minusCounter() {
    _count--;
    notifyListeners();
  }
}
