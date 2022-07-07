import 'package:flutter/cupertino.dart';
import 'uiplayer/example_mini_player.dart';
import 'database/user_database.dart';
import 'database/userdao.dart';
import 'home_general_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   UserDatabase db =
//   await $FloorUserDatabase.databaseBuilder(user_table_name).build();
//   runApp(HomeGeneralScreen(db));
// }

void main() {
// when test run only one line code similar screen test
  // runApp(Nav1Screen());
  // runApp(Nav2SampleScreen());
  // runApp(Nav2AdvancedScreen());
  // runApp(NestedScreen());
  // runApp(VideoPLayerScreen());
  runApp(AnimatedContentScreen());
  // runApp(MyApp());
}