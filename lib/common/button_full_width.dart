import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/theme/pallete.dart';

class ButtonFullWidth extends StatelessWidget {
  final VoidCallback onTap;
  final String name;
  const ButtonFullWidth({Key? key, required this.onTap, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: OutlinedButton.styleFrom(
          primary: Pallete.backgroundColor,
          backgroundColor: Pallete.greyColor,
          minimumSize: const Size.fromHeight(50),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          textStyle: const TextStyle(fontSize: 18),
        ),
        onPressed: () {},
        child: Text(name));
  }
}
