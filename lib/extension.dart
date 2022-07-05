import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void notify(String mes) {
  developer.log(mes, name: 'ManhNQ');
}

void pushLog(String mes, String tag) {
  developer.log("[$tag]  $mes", name: 'ManhNQ');
}

Widget paddingItem(Widget child, double padding) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: child,
  );
}

Widget paddingOnlyItem(
    Widget child, double left, double right, double top, double bottom) {
  return Padding(
    padding:
        EdgeInsets.only(left: left, right: right, bottom: bottom, top: top),
    child: child,
  );
}

Widget IconExpand(int flex, IconData icon, double w) {
  return Expanded(
      flex: flex,
      child: Container(width: w,
        child: Icon(
          icon,
          size: 25,
        ),
      ));
}
