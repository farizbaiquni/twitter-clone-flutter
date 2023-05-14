import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:twitter_clone_flutter/apis/user_api.dart';
import 'package:twitter_clone_flutter/core/core.dart';
import 'package:twitter_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone_flutter/models/user_model.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>((ref) {
  final UserAPI userAPI = ref.watch(userAPIProvider);
  final FlutterSecureStorage secureStorage = ref.read(secureStorageProvider);
  return TweetController(userAPI: userAPI, secureStorage: secureStorage);
});

final currentUserProfileProvider = FutureProvider((ref) async {
  // final currrentUid = await ref.watch(currentUserProvider.future);
  final tweetController = ref.watch(tweetControllerProvider.notifier);
  return await tweetController.getCurrentUserProfile();
});

class TweetController extends StateNotifier<bool> {
  final UserAPI _userAPI;
  final FlutterSecureStorage _secureStorage;

  TweetController(
      {required UserAPI userAPI, required FlutterSecureStorage secureStorage})
      : _userAPI = userAPI,
        _secureStorage = secureStorage,
        super(false);

  Future<UserModel?> getCurrentUserProfile() async {
    final uid = await _secureStorage.read(key: 'uid');
    print(uid);
    if (uid == null) return null;
    final document = await _userAPI.getDataProfile(uid);
    return UserModel.fromMap(document.data);
  }
}
