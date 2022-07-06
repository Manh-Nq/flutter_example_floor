import 'dart:developer' as developer;
import 'dart:ui';

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