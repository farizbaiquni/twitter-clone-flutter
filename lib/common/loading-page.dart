import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class LoadingPage extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const LoadingPage());
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Loading(),
    );
  }
}
