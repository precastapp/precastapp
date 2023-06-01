import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:precastapp/local_storage/local_storage.dart';
import 'package:precastapp/services/account_service.dart';
import 'package:precastapp/services/auth0_account_service.dart';

import 'local_storage/local_storage_shared_preference_impl.dart';
import 'widgets/snack_messages.dart';

Future<void> configureApp() async {
  await LocalStorageSharedPreferencesImpl.init();
  Get.lazyPut<LocalStorage>(() => LocalStorageSharedPreferencesImpl(),
      fenix: true);
  Get.lazyPut<AccountService>(() => Auth0AccountService(), fenix: true);
  defaultErrorHandler();
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
