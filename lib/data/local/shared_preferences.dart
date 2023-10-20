import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  Future<bool?> loadSettings(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(name);
  }

  Future saveSetting(String settingName, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(settingName, value);
  }
}
