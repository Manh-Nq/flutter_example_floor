import 'dart:developer' as developer;
import 'dart:ui';

void notify(String mes) {
  developer.log(mes, name: 'ManhNQ');
}

void pushLog(String mes, String tag) {
  developer.log("[$tag]  $mes", name: 'ManhNQ');
}

double calculateWidth(double width, double percentage) {
  double? result = lerpDouble(width * 3 / 8.0, width, percentage * 10);
  return result! > width ? width : result;
}

double calculateHeight(double percentage) {
  double? h = lerpDouble(70, 220, percentage * 10);
  if (h != null) {
    if (h > 220) {
      h = 220;
    } else {
      h = h;
    }
  }
  return h ?? 70;
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
