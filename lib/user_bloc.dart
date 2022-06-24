import 'dart:async';
import 'dart:math';

import 'package:sqlite_demo/database/user_database.dart';
import 'package:sqlite_demo/database/user_entity.dart';
import 'database/userdao.dart';
import 'extension.dart';

class UserBloc {
  final StreamController<List<User>> _streamUserController =
      StreamController<List<User>>();

  Stream get userStream => _streamUserController.stream;

  final StreamController<String> _streamNameController =
      StreamController<String>();

  Stream get nameStream => _streamNameController.stream;

  Future<void> getUserByID(UserDatabase db, int id) async {
    var name = await db.userDao.findUserNameByID(id);
    _streamNameController.sink.add(name ?? "");
  }

  Future<void> insertUser(UserDao dao) async {
    var id = Random().nextInt(100000000);
    var user = User(id, "name:$id", "Ha Noi", "11/11/1996");
    await dao.addUser(user);
  }

  Future<void> deleteUser(UserDao dao) async {
    notify("delete-----");
    await dao.deleteUser();
  }

  void dispose() {
    _streamUserController.close();
  }
}
