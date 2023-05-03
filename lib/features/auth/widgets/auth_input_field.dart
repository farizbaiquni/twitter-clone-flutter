import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/theme/pallete.dart';

class AuthInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const AuthInputField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(22),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Pallete.blueColor, width: 3)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Pallete.greyColor,
              )),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 18)),
      obscureText: obscureText,
      enableSuggestions: !obscureText,
      autocorrect: !obscureText,
    );
  }
}
