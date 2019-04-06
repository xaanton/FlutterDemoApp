import 'package:flutter/material.dart';
import 'github_user.dart';
import 'github_user_service.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
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

class StatefulRow extends StatefulWidget {
  final List<User> users;
  StatefulRow(this.users);
  @override
  _StatefulRowState createState() => _StatefulRowState();
}

class _StatefulRowState extends State<StatefulRow> {

  User _user;

  Widget build(BuildContext context) {
    _user = getRandomUser();
    return getUserRow(_user);
  }

  User getRandomUser() {
    var rng = new Random();
    //print(rng.nextInt(100));
    return widget.users[rng.nextInt(widget.users.length)];
  }

  Row getUserRow(User user) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Container(
            color: Colors.blue[100],
            child: Image.network(user.avatarUrl, height: 128.0, width: 128.0),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            color: Colors.blue[200],
            child: Text(user.login),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.all(5),
            child: FlatButton(
                color: Colors.purple[100],
                onPressed: () => {setState(() {
                  _user = getRandomUser();
                })} ,
                child: Icon(Icons.refresh)
            ),
          ),
        ),
      ],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {

  int _userNumber = 5;

  List<User> _userList = new List<User>();

  Future<void> _setUsers() async {
    var userList = await getAllUsers();
    setState(() {
      _userList = userList;
    });
  }

  Column getUserListRows() {
    List<StatefulRow> rowList = new List<StatefulRow>();
    for(var i = 0; i < _userNumber; i++) {
      rowList.add(new StatefulRow(_userList));
    }
    return new Column(children: rowList,);
  }

  @override
  Widget build(BuildContext context) {
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
            getUserListRows()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setUsers,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
