import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

void appShowSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

String getNameFromEmail({required String email}) {
  String name = email.split('@')[0];
  return name;
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker imagePicker = ImagePicker();
  final pickedImages = await imagePicker.pickMultiImage();
  if (pickedImages.isNotEmpty) {
    for (final image in pickedImages) {
      images.add(File(image.path));
    }
  }
  return images;
}

Future<String?> getSession(FlutterSecureStorage secureStorage) async {
  final session = await secureStorage.read(key: 'session');
  return session;
}

bool isBeforeISODate(String dateString) {
  try {
    final date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    if (now.compareTo(date) == -1) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
}
