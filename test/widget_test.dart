// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:test_app/main.dart';

import 'dart:io';

import 'package:test_app/users_bloc_loading_widget.dart';
import 'package:test_app/users_bloc_result_widget.dart';
import 'package:test_app/users_bloc_empty_widget.dart';

void main() {
  print("Widgets Tests started ");
  testWidgets('Initial display test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    //expect(find.byElementType(FloatingActionButton, skipOffstage:false), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(UsersBlocLoadingWidget), findsOneWidget);
    expect(find.byType(UsersBlocResultWidget), findsOneWidget);
    expect(find.byType(UsersBlocEmptyWidget), findsOneWidget);
    expect(find.text('Click button to get suggestions'), findsOneWidget);
    expect(find.text('Get user event sent to analytics'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    //await tester.tap(find.byIcon(Icons.add));
    //await tester.pump();
  });
  print("Widgets Tests finished ");
}
