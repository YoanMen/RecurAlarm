import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recurring_alarm/domain/entities/bool_setting.dart';
import 'package:recurring_alarm/domain/usecases/setting_usecase.dart';
import 'package:recurring_alarm/presentation/settings/viewmodel/settings_state.dart';

final settingViewModel =
    StateNotifierProvider.autoDispose<SettingsViewModel, SettingState>((ref) {
  return SettingsViewModel(
      const SettingState(
        darkMode: BoolSetting("darkMode", false),
        alarmMode: BoolSetting("alarmMode", true),
      ),
      ref.watch(settingUsecase));
});

class SettingsViewModel extends StateNotifier<SettingState> {
  SettingsViewModel(SettingState state, this._settingUsecase) : super(state) {
    loadSettings();
  }

  final SettingUsecase _settingUsecase;

  Future loadSettings() async {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    try {
      state = state.copyWith(
        alarmMode: BoolSetting(
            "alarmMode",
            await _settingUsecase.loadBoolSetting("alarmMode") ??
                state.alarmMode.value),
        darkMode: BoolSetting("darkMode",
            await _settingUsecase.loadBoolSetting("darkMode") ?? isDarkMode),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: "Error to load $e");
    }
  }

  Future saveBoolSetting(String settingName, bool value) async {
    try {
      switch (settingName) {
        case "alarmMode":
          state = state.copyWith(alarmMode: BoolSetting("alarmMode", !value));
          break;
        case "darkMode":
          state = state.copyWith(darkMode: BoolSetting("darkMode", !value));
          break;
      }

      await _settingUsecase.saveBoolSetting(settingName, !value);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error on save $e");
    }
  }
}
