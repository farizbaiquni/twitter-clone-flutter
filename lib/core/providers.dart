import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:twitter_clone_flutter/contants/constants.dart';

final appWriteClientProvider = Provider((ref) {
  Client client = Client();
  return client
      .setEndpoint(AppWriteContants.endPoint)
      .setProject(AppWriteContants.projectId)
      .setSelfSigned(status: true);
});

final appWriteAccountProvider = Provider((ref) {
  final client = ref.watch(appWriteClientProvider);
  return Account(client);
});

final appWriteDatabaseProvider = Provider((ref) {
  final client = Databases(ref.watch(appWriteClientProvider));
  return client;
});

final Provider<FlutterSecureStorage> secureStorageProvider = Provider((ref) {
  final storage = new FlutterSecureStorage();
  return storage;
});
