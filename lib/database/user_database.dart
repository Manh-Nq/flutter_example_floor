import 'package:floor/floor.dart';
import 'package:sqlite_demo/database/userdao.dart';

import 'user_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'user_database.g.dart';

@Database(version: 1, entities: [User])
abstract class UserDatabase extends FloorDatabase {
  UserDao get userDao;
}
