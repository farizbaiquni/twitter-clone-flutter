import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_flutter/common/common.dart';
import 'package:twitter_clone_flutter/common/loading-page.dart';
import 'package:twitter_clone_flutter/contants/constants.dart';
import 'package:twitter_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone_flutter/features/auth/widgets/widgets.dart';
import 'package:twitter_clone_flutter/theme/pallete.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpView());
  const SignUpView({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appBar = UIConstans.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() {
    ref.read(authControllerProvider.notifier).signUp(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? LoadingPage()
          : Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    //Text input 1
                    AuthInputField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    //Text input 2
                    AuthInputField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    //Button
                    ButtonFullWidth(
                      onTap: signUp,
                      name: 'Sign Up',
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //Text span
                    RichText(
                        text: TextSpan(
                            text: 'Already have an account? ',
                            style: const TextStyle(
                              color: Pallete.greyColor,
                              fontSize: 16,
                            ),
                            children: [
                          TextSpan(
                              text: 'Login',
                              style: const TextStyle(
                                color: Pallete.blueColor,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                })
                        ]))
                  ],
                ),
              ),
            ),
    );
  }
}
