import 'package:flutter_bloc_hive_todo/models/user.dart';
import 'package:hive/hive.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('usersBox');

    await _users.clear();

    await _users.add(User('testuser1', 'password'));
    await _users.add(User('testuser2', 'password'));
  }

  Future<String?> authenticateUser(
      final String username, final String password) async {
    final success = _users.values.any((element) =>
        element.username == username && element.password == password);
    if (success) {
      return username;
    } else {
      return null;
    }
  }

  Future createUser(final String username, final String password) async {
    final alreadyExists = _users.values.any(
        (element) => element.username.toLowerCase() == username.toLowerCase());
    if (alreadyExists) {
      return UserCreationResult.already_exists;
    }

    try {
      _users.add(User(username, password));
      return UserCreationResult.success;
    } on Exception catch (ex) {
      return UserCreationResult.failure;
    }

    // if (alreadyExists) {
    //   return userCreationResult.already_exists;
    // }

    // try {
    //   _users.add(User(username, password));
    //   return userCreationResult.success;
    // } on Exception catch (e) {
    //   return userCreationResult.failure;
    // }
  }
}

enum UserCreationResult { success, failure, already_exists }
