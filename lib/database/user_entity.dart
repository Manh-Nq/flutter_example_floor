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
  return User(id, "name:$id", "Ha Noi", "11/11/1996");
}
