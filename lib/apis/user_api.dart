import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_flutter/contants/constants.dart';
import 'package:twitter_clone_flutter/core/core.dart';
import 'package:twitter_clone_flutter/models/user_model.dart';

final userAPIProvider = Provider((ref) {
  final db = ref.watch(appWriteDatabaseProvider);
  return UserAPI(db: db);
});

abstract class InterfaceUserAPI {
  FutureEitherVoid addUserInDatabase(UserModel userModel);
}

class UserAPI extends InterfaceUserAPI {
  final Databases database;
  UserAPI({required Databases db}) : database = db;

  @override
  FutureEitherVoid addUserInDatabase(UserModel userModel) async {
    try {
      await database.createDocument(
          databaseId: AppWriteContants.databaseId,
          collectionId: AppWriteContants.usersCollectionId,
          documentId: ID.unique(),
          data: userModel.toMap());
      return const Right(null);
    } on AppwriteException catch (error, stackTrace) {
      return Left(Failure(error.message.toString(), stackTrace));
    } catch (error, stackTrace) {
      return Left(Failure(error.toString(), stackTrace));
    }
  }
}
