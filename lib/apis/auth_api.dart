import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_flutter/core/core.dart';
import 'package:either_dart/either.dart';
import 'package:twitter_clone_flutter/core/providers.dart';

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appWriteAccountProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  AppFutureEither<User> signUp(
      {required String email, required String password});
  AppFutureEither<Session> login(
      {required String email, required String password});
  Future<User?> currentUser();
}

class AuthAPI extends IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  Future<User?> currentUser() async {
    try {
      return await _account.get();
    } on AppwriteException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

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

  @override
  AppFutureEither<Session> login(
      {required String email, required String password}) async {
    try {
      Session session =
          await _account.createEmailSession(email: email, password: password);
      return Right(session);
    } on AppwriteException catch (e, stackTrace) {
      return Left(
          Failure(e.message ?? "Some unexpected error occured", stackTrace));
    } catch (e, stackTrace) {
      return Left(Failure(e.toString(), stackTrace));
    }
  }
}
