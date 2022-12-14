import 'package:get_it/get_it.dart';
import 'package:on_call_protection/core/models/body/reset_password_body.dart';
import 'package:on_call_protection/core/models/body/signup_body.dart';
//project 4
import 'core/config/config.dart';
import 'core/enums/env.dart';
import 'core/services/auth_service.dart';
import 'core/services/database_service.dart';
import 'core/services/local_storage_service.dart';

GetIt locator = GetIt.instance;

setupLocator(Env env) async {
  locator.registerSingleton(Config(env));
  locator.registerSingleton(LocalStorageService());
  locator.registerSingleton<SignUpBody>(SignUpBody());
  locator.registerSingleton<ResetPasswordBody>(ResetPasswordBody());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerSingleton<AuthService>(AuthService());
}
