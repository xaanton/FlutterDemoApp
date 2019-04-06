import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'users_state.dart';
import 'github_user_service.dart';

class UsersBloc {
  final Sink<int> onGetNewUsers;
  final Stream<UsersState> state;

  factory UsersBloc() {
    final onGetNewUsers = PublishSubject<int>();

    final state = onGetNewUsers

        .debounce(const Duration(milliseconds: 250))
        .switchMap<UsersState>((int term) => _search(term))
        .startWith(UsersLoading());

    return UsersBloc._(onGetNewUsers, state);
  }

  UsersBloc._(this.onGetNewUsers, this.state);

  void dispose() {
    onGetNewUsers.close();
  }

  static Stream<UsersState> _search(int term) async* {
    try {
      yield UsersLoading();
      final result = await source.getData();
      print(result);
      yield UsersPopulated(result);
    } catch (e) {
      yield UsersError();
    }

  }
}