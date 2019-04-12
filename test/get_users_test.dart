// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import 'package:test_app/users_bloc.dart';
import 'package:test_app/data_provider.dart';
import 'package:test_app/github_user.dart';
import 'package:test_app/users_state.dart';

class UsersProviderMock extends Mock implements UsersDataProvider{

}

void main() {
  group('getUsers', () {
    test('getUsersPopulated', () async {
      final usersProvider = UsersProviderMock();

      List<User> list = new List<User>();
      list.add(new User());

      when(usersProvider.getAllUsers(10))
          .thenAnswer((_) async => list);


      UsersBloc bloc = new UsersBloc(usersProvider);

      scheduleMicrotask(() {
        bloc.onGetNewUsers.add(10);
      });

      expect(
        bloc.state,
        emitsInOrder([isInstanceOf<UsersEmpty>(),isInstanceOf<UsersLoading>(),isInstanceOf<UsersPopulated>()]),
      );

    });

    test('getUsersEmpty', () async {

      final usersProvider = UsersProviderMock();

      List<User> list = new List<User>();
      //list.add(new User());
      when(usersProvider.getAllUsers(10))
          .thenAnswer((_) async => list);

      UsersBloc bloc = new UsersBloc(usersProvider);

      scheduleMicrotask(() {
        bloc.onGetNewUsers.add(10);
      });

      expect(
        bloc.state,
        emitsInOrder([isInstanceOf<UsersEmpty>(),isInstanceOf<UsersLoading>(),isInstanceOf<UsersEmpty>()]),
      );

    });

  });
}
