import 'package:flutter/material.dart';
import 'dart:math';
import 'users_state.dart';
import 'users_bloc.dart';
import 'users_module.dart';
import 'users_bloc_result_widget.dart';
import 'users_bloc_loading_widget.dart';
import 'users_bloc_empty_widget.dart';
import 'users_module.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

final injector = ServiceProvider().initialise(Injector.getInjector());
void main() => runApp(
    MyApp()
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Flutter Demo Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  UsersBloc bloc;
  static final int _userNumber = 5;

  @override
  void initState() {
    super.initState();
    bloc = UsersBloc(provider: injector.get(key: "users_provider"));
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  static int getRandomNumber() {
    var rng = new Random();
    //print(rng.nextInt(100));
    return rng.nextInt(1000);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersState>(
        stream: bloc.state,
        initialData: UsersEmpty(),
        builder: (BuildContext context, AsyncSnapshot<UsersState> snapshot) {
          final state = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              textTheme: TextTheme(
                title: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic, color: Colors.amberAccent),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  UsersBlocResultWidget(
                      visible: state is UsersPopulated,
                      userNumber: _userNumber,
                      userList: state is UsersPopulated ? state.result : []
                  ),
                  UsersBlocEmptyWidget(visible: state is UsersEmpty),
                  UsersBlocLoadingWidget(visible: state is UsersLoading),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => bloc.onGetNewUsers.add(getRandomNumber()),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
    );
  }
}
