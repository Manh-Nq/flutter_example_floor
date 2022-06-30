import 'dart:developer' as developer;

void notify(String mes) {
  developer.log(mes, name: 'ManhNQ');
}

void pushLog(String mes, String tag) {
  developer.log("[$tag]  $mes", name: 'ManhNQ');
}