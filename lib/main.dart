import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_flutter/common/common.dart';
import 'package:twitter_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone_flutter/features/auth/view/login_view.dart';
import 'package:twitter_clone_flutter/features/home/view/home_view.dart';
import 'package:twitter_clone_flutter/theme/theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: ref.watch(currentSessionProvider).when(
          data: (session) {
            if (session != null) {
              if (session) return const HomeView();
              return const LoginView();
            }
            return const LoginView();
          },
          error: (error, stackTrace) =>
              ErrorPage(errorMessage: error.toString()),
          loading: () => const LoadingPage()),
    );
  }
}
