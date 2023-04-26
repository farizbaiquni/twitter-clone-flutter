import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:twitter_clone_flutter/core/core.dart';
import 'package:either_dart/either.dart';

abstract class IAuthAPI {
  AppFutureEither<User> signUp(
      {required String email, required String password});
}

class AuthApi extends IAuthAPI {
  final Account _account;
  AuthApi({required Account user}) : _account = user;

  @override
  AppFutureEither<User> signUp(
      {required String email, required String password}) async {
    try {
      User user = await _account.create(
          userId: ID.unique(), email: email, password: password);
      return Right(user);
    } on AppwriteException catch (e, stackTrace) {
      return Left(
          Failure(e.message ?? "Some unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
}
