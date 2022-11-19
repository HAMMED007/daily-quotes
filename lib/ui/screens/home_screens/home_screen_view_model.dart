import 'package:on_call_protection/core/others/base_view_model.dart';
import 'package:on_call_protection/core/services/auth_service.dart';
import 'package:on_call_protection/locator.dart';

class HomeViewModel extends BaseViewModel {
  AuthService authService = locator<AuthService>();
}
