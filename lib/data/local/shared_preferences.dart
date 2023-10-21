import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesManager = Provider<SharedPreferencesManager>((ref) {
  return SharedPreferencesManager();
});

class SharedPreferencesManager {
  Future<bool?> loadBoolSettings(String settingName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(settingName);
  }

  Future saveBoolSettings(String settingName, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(settingName, value);
  }
}
