import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/settings/setting_container.dart';
import 'package:recurring_alarm/presentation/settings/viewmodel/settings_viewmodel.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar:
          AppBar(leading: const BackButton(), title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(children: [
          SettingContainer(
              settingName: ref.read(settingViewModel).notifiedTomorrow.name,
              settingText:
                  "Advance notice of the following day's notifications",
              value: ref.watch(settingViewModel).notifiedTomorrow.value),
          SettingContainer(
              settingName: ref.read(settingViewModel).darkMode.name,
              settingText: "Dark mode",
              value: ref.watch(settingViewModel).darkMode.value),
          SettingContainer(
              settingName: ref.read(settingViewModel).alarmMode.name,
              settingText: "Alarm mode notification",
              value: ref.watch(settingViewModel).alarmMode.value),
          const Spacer(),
          TextButton(
              onPressed: () => ref.read(reminderViewModel.notifier).clearAll(),
              child: const Text("Clear Reminders")),
          const Text("Reccuring Alarm - v0.01"),
        ]),
      ),
    );
  }
}
