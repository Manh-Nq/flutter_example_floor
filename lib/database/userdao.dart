
import 'package:floor/floor.dart';
import 'package:sqlite_demo/database/user_entity.dart';

const String user_table_name = "User_TABLE";

@dao
abstract class UserDao {
  @Query('SELECT * FROM User')
  Stream<List<User>> getAllUsers();

  @Query('SELECT name FROM User WHERE id = :id')
  Future<String?> findUserNameByID(int id);

  @Update()
  Future<void> updateUser(User user);

  @Query('DELETE FROM User')
  Future<void> deleteUser();

  @Query('DELETE FROM User WHERE random() > 5534023222112865485')
  Future<void> deleteRandom();

  @insert
  Future<void> addUser(User user);
}
