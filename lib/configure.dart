import 'dart:ui';

import 'package:account/account.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/snack_messages.dart';

Future<void> configureApp() async {
  await LocalStorageSharedPreferencesImpl.init();
  Get.lazyPut<LocalStorage>(() => LocalStorageSharedPreferencesImpl(),
      fenix: true);
  Get.lazyPut<AccountService>(() => Auth0AccountService(storage: Get.find()),
      fenix: true);
  defaultErrorHandler();

  var user = await Get.find<AccountService>().loadUser();
  if (user != null) Get.put(user, permanent: true);
}

void defaultErrorHandler() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    snackError(details.exception.toString(), stackTrace: details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    snackError(error.toString(), stackTrace: stack);
    return true;
  };
}
