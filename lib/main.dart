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
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';


final injector = ServiceProvider().initialise(Injector.getInjector());
void main() => runApp(
    MyApp()
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test App',
      navigatorObservers: <NavigatorObserver>[observer],
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Flutter Demo Home', analytics: analytics, observer: observer,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.analytics, this.observer}) : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _MyHomePageState createState() => _MyHomePageState(analytics, observer);
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState(this.analytics, this.observer);

  UsersBloc bloc;
  String _message = '';
  static final int _userNumber = 5;
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;

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

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  static int getRandomNumber() {
    var rng = new Random();
    //print(rng.nextInt(100));
    return rng.nextInt(1000);
  }

  Future<void> _sendAnalyticsGetUserEvent() async {
    await analytics.logEvent(
      name: 'get_users_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        'bool': true,
      },
    );
    setMessage("Get user event sent to analytics");
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
                  Text(_message),
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
              onPressed: () => {
                _sendAnalyticsGetUserEvent(),
                bloc.onGetNewUsers.add(getRandomNumber())
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
    );
  }
}
