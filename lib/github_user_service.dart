import 'package:http/http.dart' as http;
import 'dart:async';
import 'github_user.dart';
import 'dart:io';

String url = 'https://api.github.com/users';

Future<List<User>> getAllUsers() async {
  final response = await http.get(url);
  print(response.body);
  return allUsersFromJson(response.body);
}


/*
Future<User> getPost() async{
  final response = await http.get('$url/1');
  return usersFromJson(response.body);
}
*/

/*
Future<http.Response> createPost(User post) async{
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: usersToJson(post)
  );
  return response;
}
*/