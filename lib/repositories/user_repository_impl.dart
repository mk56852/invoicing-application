import 'package:drift/drift.dart';
import 'package:management_app/database/database.dart';
import 'package:management_app/models/user.dart';
import 'package:management_app/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  AppDatabase db = AppDatabase();
  @override
  Future<int> add(User user) async {
    return await db.into(db.userEntity).insert(UserEntityCompanion(
        name: Value(user.name),
        ref: Value(user.ref),
        price: Value(user.price),
        title: Value(user.title)));
  }

  @override
  Future<void> delete(int id) async {
    await (db.delete(db.userEntity)..where((item) => item.id.equals(id))).go();
  }

  @override
  Future<List<User>> getAll() async {
    List<User> users = [];
    await db.select(db.userEntity).get().then((elements) {
      for (var item in elements) {
        users.add(User(
            id: item.id,
            name: item.name,
            ref: item.ref,
            title: item.title,
            price: item.price));
      }
    });
    return users;
  }

  @override
  Future<User> getById(int id) async {
    var user = await (db.select(db.userEntity)
          ..where((item) => item.id.equals(id)))
        .getSingle();
    return User(
        id: user.id,
        name: user.name,
        ref: user.ref,
        title: user.title,
        price: user.price);
  }

  @override
  Future<int> update(User user) async {
    return await (db.update(db.userEntity)
          ..where((item) => item.id.equals(user.id)))
        .write(UserEntityCompanion(
            name: Value(user.name),
            ref: Value(user.ref),
            title: Value(user.title),
            price: Value(user.price)));
  }
}
