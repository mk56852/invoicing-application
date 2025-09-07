import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_app/models/user.dart';
import 'package:management_app/repositories/user_repository.dart';
import 'package:management_app/repositories/user_repository_impl.dart';

class UserNotifier extends StateNotifier<List<User>> {
  UserRepository repo = UserRepositoryImpl();

  UserNotifier() : super([]);

  Future<void> fetchData() async {
    if (state.isEmpty) {
      await repo.getAll().then((users) => state = users);
    }
  }

  Future<int> addUser(User user) async {
    int result = await repo.add(user);
    user.id = result;
    state = [...state, user];
    return result;
  }

  void deleteUser(int userId) async {
    await repo.delete(userId);
    state.removeWhere((item) => item.id == userId);
    state = [...state];
  }
}

StateNotifierProvider<UserNotifier, List<User>> userNotifierProvider =
    StateNotifierProvider<UserNotifier, List<User>>((var x) => UserNotifier());
