import 'package:flutter/material.dart';

void appShowSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

String getNameFromEmail({required String email}) {
  String name = email.split('@')[0];
  return name;
}
