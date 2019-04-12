import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'users_state.dart';
import 'data_provider.dart';
import 'github_user_service.dart';
import 'package:firebase_core/firebase_core.dart';

class UsersBloc {
  final Sink<int> onGetNewUsers;
  final Stream<UsersState> state;

  factory UsersBloc(UsersDataProvider provider) {
    final onGetNewUsers = PublishSubject<int>();

    final state = onGetNewUsers
        .debounce(const Duration(milliseconds: 250))
        .switchMap<UsersState>((int since) => _search(since, provider: provider))
        .startWith(UsersEmpty());
    onGetNewUsers.add(1);

    return UsersBloc._(onGetNewUsers, state);
  }

  UsersBloc._(this.onGetNewUsers, this.state);

  void dispose() {
    onGetNewUsers.close();
  }

  static Stream<UsersState> _search(int since, {UsersDataProvider provider}) async* {

    if(provider != null) {
      try {
        yield UsersLoading();
        final result = await provider.getAllUsers(since);

        if(result.isEmpty){
          yield UsersEmpty();
        } else {
          yield UsersPopulated(result);
        }

      } catch (e) {
        print(e.toString());
        yield UsersError();
      }
    } else {
      yield UsersLoading();
    }
  }
}