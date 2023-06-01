import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/util.dart';
import 'simple_action_dialog.dart';

class SuccessDialog extends StatelessWidget {
  String message;

  SuccessDialog([String? message])
      : message = message ?? 'Successfully performed operation'.tr;

  @override
  Widget build(BuildContext context) {
    return SimpleActionDialog(
      title: '',
      actionLabel: 'Close'.tr,
      action: () => Get.back(result: true),
      children: [
        Icon(Icons.thumb_up_alt_sharp, color: Get.theme.primaryColor, size: 80),
        SizedBox(height: kPadding),
        Text(message, style: Get.textTheme.headlineMedium),
      ],
    );
  }
}
