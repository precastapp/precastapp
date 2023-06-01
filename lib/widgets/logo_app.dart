import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoApp extends StatelessWidget {
  bool darkMode = Get.isDarkMode;
  double width;
  bool hero;

  LogoApp({bool? darkMode, this.width = 150, this.hero = true}) {
    this.darkMode = darkMode ?? this.darkMode;
  }

  @override
  Widget build(BuildContext context) {
    var icon = Image.asset(
      'images/logo${darkMode ? '-dark' : ''}.png',
      //semanticsLabel: 'logo of app RAMS'.tr,
      width: width,
    );
    if (hero != true) return icon;
    return Hero(tag: 'logo-app', child: icon);
  }
}
