import 'package:http/http.dart' as http;
import 'dart:async';
import 'github_user.dart';
import 'dart:io';
import 'data_provider.dart';
import 'url_provider_sevice.dart';


class UsersApiDataProvider implements UsersDataProvider{

  final UrlProvider _urlProvider;

  UsersApiDataProvider( this._urlProvider ) ;

  Future<List<User>> getAllUsers(int since) async {
    final response = await http.get(_urlProvider.getGithubUsersApiUrl() + "?since=" + since.toString());
    print(response.body);
    return allUsersFromJson(response.body);
  }

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