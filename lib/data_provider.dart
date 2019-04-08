import 'github_user.dart';

abstract class UsersDataProvider {
  Future<List<User>> getAllUsers(int since);
}