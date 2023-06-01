import 'package:get/get.dart';

extension StringUtil on String? {
  bool isEmptyOrNull() {
    return this == null || this!.isEmpty;
  }

  String trf(String fallback) {
    var translated = this?.tr;
    if (translated == this) translated = fallback;
    return translated!;
  }
}
