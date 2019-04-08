import 'package:inject/inject.dart';
import 'package:test_app/github_user_service.dart';
import 'data_provider.dart';
import 'package:test_app/url_provider_sevice.dart';

@module
class ServiceProvider{
  @provide
  UsersApiDataProvider provideUsersDataProvider(UrlProvider urlP) => new UsersApiDataProvider(urlP);

  @provide
  UrlProvider provideUrlProvider() => new UrlProvider();
}