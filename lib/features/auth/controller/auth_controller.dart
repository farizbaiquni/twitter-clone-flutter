import 'package:appwrite/models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_flutter/apis/auth_api.dart';
import 'package:twitter_clone_flutter/features/auth/view/login_view.dart';
import 'package:twitter_clone_flutter/features/home/view/home_view.dart';

import '../../../core/core.dart';

final AuthControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authAPI: ref.watch(authAPIProvider));
});

final CurrentUserProvider = FutureProvider((ref) {
  final authController = ref.watch(AuthControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);

  Future<User?> currentUser() => _authAPI.currentUser();

  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final response = await _authAPI.signUp(email: email, password: password);
    response.fold(
        (left) => appShowSnackBar(context: context, content: left.message),
        (right) {
      appShowSnackBar(
          context: context, content: "Sign up success, please login");
      Navigator.push(context, LoginView.route());
    });
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
        (right) {
      appShowSnackBar(context: context, content: "login success");
      Navigator.push(context, HomeView.route());
    });
  }
}
