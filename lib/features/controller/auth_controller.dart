import 'dart:js';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_flutter/apis/auth_api.dart';

import '../../core/core.dart';

final AuthControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authAPI: ref.watch(authAPIProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);

  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final response = await _authAPI.signUp(email: email, password: password);
    response.fold(
        (left) => appShowSnackBar(context: context, content: left.message),
        (right) =>
            appShowSnackBar(context: context, content: "Sign up success"));
    state = false;
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final response = await _authAPI.login(email: email, password: password);
    state = false;
    response.fold(
        (left) => appShowSnackBar(context: context, content: left.message),
        (right) => appShowSnackBar(context: context, content: "login success"));
  }
}
