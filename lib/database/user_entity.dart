import 'dart:math';

import 'package:floor/floor.dart';

@Entity(tableName: "User")
class User {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String name, address, date;

  User(this.id, this.name, this.address, this.date);

  @override
  String toString() {
    // TODO: implement toString
    return "id : $id - name: $name\n";
  }
}

User fakeUser(int id) {
  var rd= Random();
  return User(id, "name:$id", "Ha Noi",
      "${rd.nextInt(30)}/${rd.nextInt(12)}/19${rd.nextInt(99)}");
}
