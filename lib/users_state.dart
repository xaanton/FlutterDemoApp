import 'github_user.dart';

class UsersState {}

class UsersLoading extends UsersState {}

class UsersError extends UsersState {}

class UsersNoTerm extends UsersState {}

class UsersPopulated extends UsersState {
  final List<User> result;
  UsersPopulated(this.result);
}

class UsersEmpty extends UsersState {}