import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/settings/setting_container.dart';
import 'package:recurring_alarm/presentation/settings/viewmodel/settings_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(),
          title: Text(AppLocalizations.of(context)!.setting)),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(children: [
          SettingContainer(
              settingName: ref.read(settingViewModel).darkMode.name,
              settingText: AppLocalizations.of(context)!.darkModeSetting,
              value: ref.watch(settingViewModel).darkMode.value),
          SettingContainer(
              settingName: ref.read(settingViewModel).alarmMode.name,
              settingText: AppLocalizations.of(context)!.alarmSetting,
              value: ref.watch(settingViewModel).alarmMode.value),
          const Spacer(),
          const Text("RecurAlarm - v1.0.0"),
        ]),
      ),
    );
  }
}
