import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/failure.dart';
import 'package:recurring_alarm/data/local/shared_preferences.dart';

final settingUsecase = Provider<SettingUsecase>((ref) {
  return SettingUsecase(ref.watch(sharedPreferencesManager));
});

class SettingUsecase {
  SettingUsecase(this.sharedPreferencesManager);
  SharedPreferencesManager sharedPreferencesManager;

  Future<bool?> loadBoolSetting(String settingName) async {
    try {
      return await sharedPreferencesManager.loadBoolSettings(settingName);
    } catch (e) {
      throw Failure(message: "error $e");
    }
  }

  Future saveBoolSetting(String settingName, bool value) async {
    try {
      await sharedPreferencesManager.saveBoolSettings(settingName, value);

      print("saved $settingName $value");
    } catch (e) {
      throw Failure(message: "error $e");
    }
  }
}
