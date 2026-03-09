import 'package:admin_server/database/mysql.dart';
import 'package:admin_server/features/user/user_model.dart';
import 'package:admin_server/features/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final MySqlDatabase mySql;
  const UserRepositoryImpl(this.mySql);

  @override
  Future<List<UserEntity>> getList() async {
    final cnn = await mySql.getConnection();
    final result = await cnn.query('''SELECT * FROM users''');
    await cnn.close();
    if (result.isEmpty) return [];
    return result
        .map(
          (e) => UserEntity(
            email: e['email'].toString(),
            id: int.parse(e['id'].toString()),
            userName: e['username'].toString(),
            fullName: e['fullname'].toString(),
            password: e['password'].toString(),
          ),
        )
        .toList();
  }

  @override
  Future<void> create(
      {required String username,
      required String email,
      required String password,
      String? fullname}) async {
    final cnn = await mySql.getConnection();
    await cnn.query('''
    INSERT INTO users(username, password, full_name, email) VALUES(?,?,?,?)
    ''', [username, password, fullname, email]);

    await cnn.close();
  }

  @override
  Future<UserEntity?> findByUsername(String username) async {
    final cnn = await mySql.getConnection();
    final result = await cnn
        .query('''SELECT * FROM users WHERE username = '$username' ''');
    await cnn.close();
    if (result.isEmpty) return null;
    final row = result.first;
    return UserEntity(
        id: int.parse(row['id'].toString()),
        userName: row['username'].toString(),
        email: row['email'].toString(),
        password: row['password'].toString());
  }
}
