import 'package:flutter/cupertino.dart';

import 'database/user_database.dart';
import 'database/userdao.dart';
import 'home_general_screen.dart';
import 'navigation/ver1/nav1_screen.dart';
import 'navigation/ver2/advanced/nav2_advanced_screen.dart';
import 'navigation/ver2/nested/nested_screen.dart';
import 'navigation/ver2/sample_basic/nav2_sample_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   UserDatabase db =
//   await $FloorUserDatabase.databaseBuilder(user_table_name).build();
//   runApp(HomeDatabase(db));
// }

void main() {
//when test run only one line code similar screen test
  // runApp(Nav1Screen());
  // runApp(Nav2SampleScreen());
  // runApp(Nav2AdvancedScreen());
  runApp(NestedScreen());
}