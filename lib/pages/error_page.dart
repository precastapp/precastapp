import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:precastapp/widgets/error_message_widget.dart';

class ErrorPage extends StatelessWidget {
  String? message;
  StackTrace? stackTrace;

  ErrorPage({this.message, this.stackTrace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Error".tr)),
      body: ErrorMessageWidget(message, stackTrace),
    );
  }
}
