import 'dart:math';

import 'package:sqlite_demo/provider/TextChangeProvider.dart';

class User {
  final String id;
  final String name;
  final String age;

  User(this.id, this.name, this.age);
}

final users = [
  User(randomString(), 'Nguyen ${randomString()}', '${Random().nextInt(50)}'),
  User(randomString(), 'Nguyen ${randomString()}', '${Random().nextInt(50)}'),
  User(randomString(), 'Nguyen ${randomString()}', '${Random().nextInt(50)}'),
  User(randomString(), 'Nguyen ${randomString()}', '${Random().nextInt(50)}'),
  User(randomString(), 'Nguyen ${randomString()}', '${Random().nextInt(50)}'),
  User(randomString(), 'Nguyen ${randomString()}', '${Random().nextInt(50)}'),
  User(randomString(), 'Nguyen ${randomString()}', '${Random().nextInt(50)}'),
  User(randomString(), 'Nguyen ${randomString()}', '${Random().nextInt(50)}'),
  User(randomString(), 'Nguyen ${randomString()}', '${Random().nextInt(50)}'),
  User(randomString(), 'Nguyen ${randomString()}', '${Random().nextInt(50)}'),
  User(randomString(), 'Nguyen ${randomString()}', '${Random().nextInt(50)}'),
  User(randomString(), 'Nguyen ${randomString()}', '${Random().nextInt(50)}'),
];
