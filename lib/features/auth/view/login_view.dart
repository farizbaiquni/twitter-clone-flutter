import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_flutter/common/common.dart';
import 'package:twitter_clone_flutter/contants/constants.dart';
import 'package:twitter_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone_flutter/features/auth/view/sign_up_view.dart';
import 'package:twitter_clone_flutter/features/auth/widgets/widgets.dart';
import 'package:twitter_clone_flutter/theme/theme.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appBar = UIConstans.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    ref.read(AuthControllerProvider.notifier).login(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(AuthControllerProvider);
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
                      onTap: login,
                      name: 'Login',
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //Text span
                    RichText(
                        text: TextSpan(
                            text: 'Dont have an account? ',
                            style: const TextStyle(
                              color: Pallete.greyColor,
                              fontSize: 16,
                            ),
                            children: [
                          TextSpan(
                              text: 'SignUp',
                              style: const TextStyle(
                                color: Pallete.blueColor,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context, SignUpView.route());
                                })
                        ]))
                  ],
                ),
              ),
            ),
    );
  }
}
