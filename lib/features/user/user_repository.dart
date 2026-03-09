import 'package:admin_server/features/user/user_model.dart';

abstract class UserRepository {
  Future<void> create({required String username, required String email, required String password}); 

  Future<UserEntity?> findByUsername(String username);

  Future<List<UserEntity>> getList();

}
