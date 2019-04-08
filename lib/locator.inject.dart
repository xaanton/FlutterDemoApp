import 'locator.dart' as _i1;
import 'users_module.dart' as _i2;
import 'dart:async' as _i3;
import 'github_user_service.dart' as _i4;
import 'url_provider_sevice.dart' as _i5;

class SampleLocator$Injector implements _i1.SampleLocator {
  SampleLocator$Injector._(this._serviceProvider);

  final _i2.ServiceProvider _serviceProvider;

  static _i3.Future<_i1.SampleLocator> create(
      _i2.ServiceProvider serviceProvider) async {
    final injector = SampleLocator$Injector._(serviceProvider);

    return injector;
  }

  _i4.UsersApiDataProvider _createUsersApiDataProvider() =>
      _serviceProvider.provideUsersDataProvider(_createUrlProvider());
  _i5.UrlProvider _createUrlProvider() => _serviceProvider.provideUrlProvider();
  @override
  _i4.UsersApiDataProvider getUsersDataProvider() =>
      _createUsersApiDataProvider();
}
