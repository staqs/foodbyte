import 'package:flutter_foodybite/core/models/authstate.dart';
import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/users.dart';
import 'package:flutter_foodybite/core/services/authenticationservice.dart';
import 'package:flutter_foodybite/core/services/service_locator.dart';
import 'package:stacked/stacked.dart';

class AuthViewModel extends ReactiveViewModel {
  final AuthService authService = locator<AuthService>();

  AuthViewModel() {
    print("Auth View Model is Working");
    setBusy(true);
    checkLogin();
    setBusy(false);
  }

  User get getCurrentUser => authService.getCurrentUser;
  Future<AuthState> login(String email, String password) async {
    AuthState auth = await authService.login(email, password);
    print(auth);

    return auth;
  }

  Future<AuthState> checkLogin() async {
    setBusy(true);
    AuthState state = await authService.isLoggedIn();
    setBusy(false);

    return state;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [authService];
}
