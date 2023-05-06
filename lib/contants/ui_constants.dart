import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone_flutter/contants/constants.dart';
import 'package:twitter_clone_flutter/theme/theme.dart';

class UIConstans {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        colorFilter: const ColorFilter.mode(Pallete.blueColor, BlendMode.srcIn),
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static List<Widget> pageScreenList = [
    const Center(child: Text("Feed screen")),
    const Center(child: Text("Search screen")),
    const Center(child: Text("Notification screen"))
  ];
}
