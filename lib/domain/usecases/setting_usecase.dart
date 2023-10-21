import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/data/local/shared_preferences.dart';

final settingUsecase = Provider<SettingUsecase>((ref) {
  return SettingUsecase(ref.watch(sharedPreferencesManager));
});

class SettingUsecase {
  SettingUsecase(this.sharedPreferencesManager);
  SharedPreferencesManager sharedPreferencesManager;

  void loadSetting(String settingName) {}

  void saveSetting(String settingName) {}
}
