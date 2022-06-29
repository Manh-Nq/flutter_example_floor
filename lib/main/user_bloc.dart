import 'dart:async';
import 'dart:math';

import 'package:sqlite_demo/database/user_database.dart';
import 'package:sqlite_demo/database/user_entity.dart';
import 'package:sqlite_demo/extension.dart';
import 'package:sqlite_demo/provider/TextChangeProvider.dart';
import '../database/userdao.dart';

class UserBloc {
  final UserDatabase db;

  UserBloc(this.db);

  final StreamController<List<User>> _streamUserController =
      StreamController<List<User>>();

  final StreamController<String> _streamName = StreamController<String>();

  Stream get nameStream => _streamName.stream;

  Sink get event => _streamUserController.sink;

  Stream get userStream => _streamUserController.stream;

  UserDao get dao => db.userDao;

  Future<void> initData() async {
    db.userDao.getAllUsers().listen((data) {
      event.add(data);
    });
    _streamName.sink.add("hello world");
  }

  Future<void> getUserByID(int id) async {
    var user = await db.userDao.findUserNameByID(id);
    var name = user?.name;
    _streamName.sink.add(name ?? "hello");
    notify(user.toString());
  }

  Future<void> insertUser() async {
    var id = Random().nextInt(100000000);
    var user = fakeUser(id);
    await dao.addUser(user);
  }

  Future<void> deleteUserByID(int id) async {
    await dao.deleteUserByID(id);
    initData();
  }

  Future<void> update(int id) async {
    await dao.updateUser(User(id, randomString(), "new  address",
        "${Random().nextInt(30)}/${Random().nextInt(12)}/2022"));
  }

  void dispose() {
    _streamUserController.close();
  }
}
