import 'package:flutter/material.dart';
import 'stateful_row.dart';
import 'github_user.dart';

class UsersBlocResultWidget extends StatelessWidget {
  final bool visible;
  final int userNumber;
  final List<User> userList;

  const UsersBlocResultWidget({Key key, this.visible, this.userNumber, this.userList}) : super(key: key);

  Column getUserListRows() {
    List<StatefulRow> rowList = new List<StatefulRow>();

    for(var i = 0; i < (userNumber < userList.length ? userNumber : userList.length); i++) {
      rowList.add(new StatefulRow(userList));
    }
    return new Column(children: rowList,);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: visible ? 1.0 : 0.0,
      child: Container(
        alignment: FractionalOffset.center,
        child: getUserListRows(),
      ),
    );
  }
}


