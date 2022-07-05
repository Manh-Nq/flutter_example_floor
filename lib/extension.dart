import 'dart:developer' as developer;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void notify(String mes) {
  developer.log(mes, name: 'ManhNQ');
}

void pushLog(String mes, String tag) {
  developer.log("[$tag]  $mes", name: 'ManhNQ');
}

double calculateWidth(double width, double percentage) {
  double? _width = lerpDouble(120, width, percentage * 10);
  if (_width != null) {
    if (_width > width) {
      _width = width;
    } else {
      _width = _width;
    }
  }
  return _width ?? 120;
}

double calculateOpacity(double percentage) {
  double? opacity = lerpDouble(1.0, 0.0, percentage * 10);

  if (opacity != null) {
    if (opacity < 0.0) {
      opacity = 0.0;
    } else {
      opacity = opacity;
    }
  }
  return opacity ?? 1.0;
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

Widget IconNav(int flex, IconData icon, double w) {
  return Expanded(
      flex: flex,
      child: Center(
          child: Container(
        width: w,
        child: Icon(
          icon,
          size: 25,
        ),
      )));
}

Widget IconExpand(int flex, IconData icon) {
  return Expanded(
    child: Icon(
      icon,
      size: 25,
    ),
    flex: 1,
  );
}
