import 'package:inject/inject.dart';
import 'data_provider.dart';
import 'users_module.dart';
import 'github_user_service.dart';
import 'locator.inject.dart' as generated;
//import '~/Flutter/test_app/.dart_tool/build/generated/locator.inject.dart' as generated;

@Injector(const [ServiceProvider])
abstract class SampleLocator {

  static create(ServiceProvider module) => generated.SampleLocator$Injector.create(module);

  @provide
  UsersApiDataProvider getUsersDataProvider();
}