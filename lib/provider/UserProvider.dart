import 'package:flutter/cupertino.dart';
import 'package:sqlite_demo/database/user_database.dart';

import '../database/userdao.dart';

class UserProvider extends ChangeNotifier {
  late UserDatabase db;

  Future<void> init() async {
    db = await $FloorUserDatabase.databaseBuilder(user_table_name).build();
  }


}
