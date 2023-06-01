import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../local_storage/local_storage.dart';

var localeSelected = Get.deviceLocale!.obs;

List<Locale> getSupportedLocales() => [
      Locale('pt', 'BR'),
      Locale('en', 'US'),
      Locale('fr', 'FR'),
      Locale('es', 'ES'),
    ];

Future<Locale> getDefaultLocale() async {
  String? savedLocade = await Get.find<LocalStorage>().read('locale');
  if (savedLocade == null) return localeSelected.value = Get.deviceLocale!;
  var divCountryIndex = savedLocade.indexOf('_');
  var lang = savedLocade.substring(
      0, divCountryIndex.isNegative ? null : divCountryIndex);
  var country = divCountryIndex.isNegative
      ? null
      : savedLocade.substring(divCountryIndex + 1);
  localeSelected.value = Locale(lang, country);
  return localeSelected.value;
}

Future<void> changeLocale(Locale locale) async {
  String langCod =
      '${locale.languageCode}${locale.countryCode != null ? '_${locale.countryCode}' : ''}';
  String data = await rootBundle.loadString('i18n/$langCod.json');
  var jsonData = Map<String, String>.from(json.decode(data));
  var translations = {langCod: jsonData};
  Get.appendTranslations(translations);
  Get.updateLocale(locale);
  await Get.find<LocalStorage>().write('locale', langCod);
}
