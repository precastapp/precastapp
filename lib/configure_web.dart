import 'dart:async';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'configure.dart' as cfg;

Future<void> configureApp() async {
  if (kDebugMode == false) setUrlStrategy(PathUrlStrategy());
  var splashScren = document.querySelector('#splash');
  Timer(const Duration(milliseconds: 300), () => splashScren?.remove());
  await cfg.configureApp();
}
