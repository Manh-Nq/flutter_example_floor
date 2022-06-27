import 'dart:async';
import 'dart:math';

import 'package:sqlite_demo/database/user_database.dart';
import 'package:sqlite_demo/database/user_entity.dart';
import '../database/userdao.dart';

class UserBloc {
  final UserDatabase db;

  UserBloc(this.db);

  final StreamController<List<User>> _streamUserController =
      StreamController<List<User>>();

  Sink get event => _streamUserController.sink;

  Stream get userStream => _streamUserController.stream;

  UserDao get dao => db.userDao;

  final StreamController<String> _streamNameController =
      StreamController<String>();

  Stream get nameStream => _streamNameController.stream;

  Future<void> initData() async {
    db.userDao.getAllUsers().listen((data) {
      event.add(data);
    });
  }

  Future<void> getUserByID(int id) async {
    var name = await db.userDao.findUserNameByID(id);
    _streamNameController.sink.add(name ?? "");
  }

  Future<void> insertUser() async {
    var id = Random().nextInt(100000000);
    var user = fakeUser(id);
    await dao.addUser(user);
  }

  Future<void> deleteUser() async {
    await dao.deleteUser();
    initData();
  }

  Future<void> deleteUserByID(int id) async {
    await dao.deleteUserByID(id);
    initData();
  }

  void dispose() {
    _streamUserController.close();
  }
}
