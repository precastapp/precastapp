import 'dart:convert';

import 'package:get/get.dart';
import 'package:precastapp/util/util.dart';

class FormErrorValidation {
  Map<String, String> fieldError = {};
  String? _message;

  String get message {
    if (_message == null || _message == 'null')
      return 'Oops! Something went wrong!\n%s'.trArgs(['Try again later.'.tr]);
    return _message!;
  }

  FormErrorValidation(String errorRaw, [StackTrace? stackTrace]) {
    print('error: $errorRaw\nstacktrace: $stackTrace');
    if (errorRaw.isEmpty) return;
    try {
      var json = jsonDecode(errorRaw);
      _message = json['message'];
      if (_message == null || !_message!.startsWith('{')) {
        if (_message?.contains('username') ?? false)
          fieldError['username'] = _message!;
        return;
      }
      json = jsonDecode(_message!);
      if (json['details'] is String) {
        _message = json['details'];
        return;
      }
      var details = (json['details'] ?? []) as List;
      for (var d in details) {
        if (fieldError.containsKey(d['path'])) continue;
        var error = d['message'] as String;
        if (d['allowedValues'] != null)
          error += ': ${(d['allowedValues'] as List).join(', ')}';
        fieldError[d['path']] = error;
      }
      var fieldsKey = fieldError.keys.join('\n');
      _message = '${json['message'] ?? ''} in fields: \n%s'.trArgs([fieldsKey]);
    } catch (ex, st) {
      _message = errorRaw;
    }
  }

  String? fieldValidator(String field, dynamic value) {
    var fieldErro = fieldError[field];
    if (fieldErro != null) return fieldErro;
    return defaultValidator(value);
  }
}
