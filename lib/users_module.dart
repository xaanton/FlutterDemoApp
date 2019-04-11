import 'package:test_app/github_user_service.dart';
import 'data_provider.dart';
import 'package:test_app/url_provider_sevice.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class ServiceProvider{
  Injector initialise(Injector injector) {
    //injector.map<Logger>((i) => Logger(), isSingleton: true);
    injector.map<UrlProvider>((i) => UrlProvider(), isSingleton: true); 
    injector.map<UsersApiDataProvider>((i) => new UsersApiDataProvider(i.get<UrlProvider>()), key:"users_provider");
    return injector;
  }
}