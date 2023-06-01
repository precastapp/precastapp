import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackError(Object error,
    {StackTrace? stackTrace, SnackBarAction? action}) {
  var msg = error.toString();

  print(msg);
  if (stackTrace != null) print(stackTrace.toString());
  BuildContext? context = Get.context;
  if (context == null) return;

  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  WidgetsBinding.instance.addPostFrameCallback(
      (_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(msg),
            duration: Duration(seconds: 4),
            action: action,
          )));
}

void snackInfo(String msg, {SnackBarAction? action}) {
  print(msg);
  BuildContext? context = Get.context;
  if (context == null) return;

  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  WidgetsBinding.instance.addPostFrameCallback(
      (_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(msg),
            duration: Duration(seconds: 4),
            action: action,
          )));
}
