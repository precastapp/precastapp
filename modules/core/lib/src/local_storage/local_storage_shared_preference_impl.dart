import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage.dart';

class LocalStorageSharedPreferencesImpl extends LocalStorage {
  static late SharedPreferences prefs;

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  T? read<T>(String key) {
    var value = prefs.get(key);
    return value as T?;
  }

  @override
  Future<void> write(String key, dynamic value) {
    switch (value.runtimeType) {
      case String:
        return prefs.setString(key, value);
      case int:
        return prefs.setInt(key, value);
      case double:
        return prefs.setDouble(key, value);
      case bool:
        return prefs.setBool(key, value);
      case const (List<String>):
        return prefs.setStringList(key, value);
      default:
        return prefs.setString(key, jsonEncode(value));
    }
  }

  @override
  Future clear() {
    return prefs.clear();
  }
}
