import 'package:management_app/models/user.dart';

abstract class UserRepository {
  Future<User> getById(int id);
  Future<List<User>> getAll();
  Future<int> add(User user);
  Future<int> update(User user);
  Future<void> delete(int id);
}
