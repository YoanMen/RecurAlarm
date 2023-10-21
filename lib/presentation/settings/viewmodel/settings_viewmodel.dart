import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recurring_alarm/domain/entities/bool_setting.dart';
import 'package:recurring_alarm/domain/usecases/setting_usecase.dart';
import 'package:recurring_alarm/presentation/settings/viewmodel/settings_state.dart';

final settingViewModel =
    StateNotifierProvider.autoDispose<SettingsViewModel, SettingState>((ref) {
  return SettingsViewModel(
      SettingState(
          notifiedTomorrow: BoolSetting("notifiedTomorrow", true),
          darkMode: BoolSetting("darkMode", false),
          alarmMode: BoolSetting("alarmMode", true)),
      ref.watch(settingUsecase));
});

class SettingsViewModel extends StateNotifier<SettingState> {
  SettingsViewModel(SettingState state, this._settingUsecase) : super(state) {
    loadSettings();
  }

  final SettingUsecase _settingUsecase;

  Future loadSettings() async {
    try {
      state = state.copyWith(
        alarmMode: BoolSetting(
            "alarmMode",
            await _settingUsecase.loadBoolSetting("alarmMode") ??
                state.alarmMode.value),
        darkMode: BoolSetting(
            "darkMode",
            await _settingUsecase.loadBoolSetting("darkMode") ??
                state.darkMode.value),
        notifiedTomorrow: BoolSetting(
            "notifiedTomorrow",
            await _settingUsecase.loadBoolSetting("notifiedTomorrow") ??
                state.notifiedTomorrow.value),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: "Error to load $e");
    }
  }

  Future saveBoolSetting(String settingName, bool value) async {
    try {
      switch (settingName) {
        case "notifiedTomorrow":
          state = state.copyWith(
              notifiedTomorrow: BoolSetting("notifiedTomorrow", !value));
          break;
        case "alarmMode":
          state = state.copyWith(alarmMode: BoolSetting("alarmMode", !value));
          break;
        case "darkMode":
          state = state.copyWith(darkMode: BoolSetting("darkMode", !value));
          break;
        default:
      }

      await _settingUsecase.saveBoolSetting(settingName, !value);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error on save $e");
    }
  }
}
