import 'package:appwrite/models.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_flutter/apis/auth_api.dart';
import 'package:twitter_clone_flutter/apis/user_api.dart';
import 'package:twitter_clone_flutter/features/auth/view/login_view.dart';
import 'package:twitter_clone_flutter/features/home/view/home_view.dart';
import 'package:twitter_clone_flutter/models/user_model.dart';

import '../../../core/core.dart';

final AuthControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authAPIProvider), userAPI: ref.watch(userAPIProvider));
});

final currentUserProvider = FutureProvider((ref) {
  final authController = ref.watch(AuthControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
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
        (right) async {
      print(right.$id);
      final userModel = UserModel(
          email: email,
          username: getNameFromEmail(email: email),
          followers: [],
          following: [],
          profilePic: '',
          bannerPic: '',
          uid: right.$id,
          bio: '',
          isTwitterBlue: false);
      final response = _userAPI.addUserInDatabase(userModel);
      response.fold(
          (left) => appShowSnackBar(context: context, content: left.message),
          (right) {
        appShowSnackBar(
            context: context, content: "Sign up success, please login");
        Navigator.push(context, LoginView.route());
      });
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
