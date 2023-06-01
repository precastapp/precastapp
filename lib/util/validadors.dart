import 'package:get/get.dart';

import 'string_util.dart';

String? fullNameValidator(String? value) {
  if (value.isEmptyOrNull()) return 'This field is requerid'.tr;
  return value!.split(' ').length < 2 ? 'Full name is required'.tr : null;
}

String? defaultValidator(dynamic value) {
  if (value == null ||
      ((value is String || value is Iterable) && value.isEmpty))
    return 'This field is requerid'.tr;

  return null;
}
