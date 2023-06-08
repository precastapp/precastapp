import 'package:flutter/material.dart';
import 'package:get/get.dart';

export 'app_container.dart';
export 'global_values.dart';
export 'locale.dart';
export 'string_util.dart';
export 'validadors.dart';

String getCurrencyFromCountry(String country) {
  switch (country) {
    case 'BR':
      return 'BRL';
    case 'HT':
      return 'HTG';
    case 'US':
      return 'USD';
    case 'CL':
      return 'CLP';
    case 'DO':
      return 'DOP';
  }
  return '';
}

RegExp get regexUsername => RegExp(r'[a-zA-Z0-9._]');

Widget get emptyList => Center(
    child: Text('No items were found'.tr, style: Get.textTheme.headlineSmall));
