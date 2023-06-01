import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ErrorMessageWidget extends StatelessWidget {
  String? message;

  ErrorMessageWidget([this.message, StackTrace? stackTrace]){
    print("Error: $message");
    if(stackTrace != null)
      print(stackTrace.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Text(
            "Oops! Something went wrong!".tr,
            textAlign: TextAlign.center,
          ),
          if (message != null) Text(message!.tr, textAlign: TextAlign.center)
        ]));
  }
}
