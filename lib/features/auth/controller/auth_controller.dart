import 'package:appwrite/models.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:twitter_clone_flutter/apis/auth_api.dart';
import 'package:twitter_clone_flutter/apis/user_api.dart';
import 'package:twitter_clone_flutter/features/auth/view/login_view.dart';
import 'package:twitter_clone_flutter/features/home/view/home_view.dart';
import 'package:twitter_clone_flutter/models/user_model.dart';

import '../../../core/core.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authAPIProvider),
      userAPI: ref.watch(userAPIProvider),
      secureStorage: ref.watch(secureStorageProvider));
});

final currentUserProvider = FutureProvider((ref) async {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

final currentSessionProvider = FutureProvider((ref) async {
  final authController = await ref.watch(authControllerProvider.notifier);
  return authController.currentSession();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  final FlutterSecureStorage _secureStorage;

  AuthController(
      {required AuthAPI authAPI,
      required UserAPI userAPI,
      required FlutterSecureStorage secureStorage})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        _secureStorage = secureStorage,
        super(false);

  Future<User?> currentUser() async {
    return await _authAPI.currentUser();
  }

  Future<UserModel?> getCurrentUserProfile(String uid) async {
    final document = await _userAPI.getDataProfile(uid);
    return UserModel.fromMap(document.data);
  }

  Future<bool?> currentSession() async {
    final session = await getSession(_secureStorage);
    if (session == null) return null;
    return isBeforeISODate(session);
  }

  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final response = await _authAPI.signUp(email: email, password: password);
    response.fold(
        (left) => appShowSnackBar(context: context, content: left.message),
        (right) async {
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
        (right) async {
      await _secureStorage.write(key: 'session', value: right.expire);
      await _secureStorage.write(key: 'uid', value: right.userId);
      appShowSnackBar(context: context, content: "login success");
      Navigator.push(context, HomeView.route());
    });
  }
}
