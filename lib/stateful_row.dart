import 'package:flutter/material.dart';
import 'github_user.dart';
import 'dart:math';

class StatefulRow extends StatefulWidget {
  final List<User> users;
  StatefulRow(this.users);
  @override
  _StatefulRowStateUser createState() => _StatefulRowStateUser();
}

class _StatefulRowStateUser extends State<StatefulRow> {
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
          flex: 3,
          child: Container(
            //color: Colors.blue[200],
            child: Text(user.login,style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.normal, color: Colors.teal)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(5),
            child: FlatButton(
                //color: Colors.purple[100],
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

/*
class _StatefulRowState extends State<StatefulRow> {
  Widget build(BuildContext context) {
    return new RefreshProgressIndicator();
  }
}
*/