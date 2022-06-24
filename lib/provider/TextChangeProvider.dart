import 'dart:math';

import 'package:flutter/material.dart';

class TextChangeProvider extends ChangeNotifier {
  String _name = "";

  String get name => _name;


  void setName() {
    _name = randomString();
    notifyListeners();
  }

  String randomString() {
    int i = 0;
    String txtConst = "1234567890qwertyuiopasdfghjklzxcvbnm";
    String txt = "";
    while (i < 10) {
      txt += txtConst[Random().nextInt(txtConst.length - 1)];
      i++;
    }
    return txt;
  }

}
