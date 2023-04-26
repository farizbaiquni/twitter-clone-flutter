import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/common/common.dart';
import 'package:twitter_clone_flutter/contants/constants.dart';
import 'package:twitter_clone_flutter/features/view/sign_up_view.dart';
import 'package:twitter_clone_flutter/features/widgets/widgets.dart';
import 'package:twitter_clone_flutter/theme/theme.dart';

class LoginView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appBar = UIConstans.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              //Text input 1
              AuthInputField(
                controller: emailController,
                hintText: 'Email',
              ),
              const SizedBox(
                height: 23,
              ),
              //Text input 2
              AuthInputField(
                controller: passwordController,
                hintText: 'Password',
              ),
              const SizedBox(
                height: 23,
              ),
              //Button
              ButtonFullWidth(
                onTap: () {},
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
