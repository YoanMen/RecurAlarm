import 'package:flutter/material.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/settings/setting_container.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(leading: const BackButton(), title: const Text("Settings")),
      body: const Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(children: [
          SettingContainer(
              settingText:
                  "Etre notifier la veille des notifications du lendemain",
              value: true),
          SettingContainer(settingText: "Mode sombre", value: false),
          SettingContainer(
              settingText: "Notification en mode alarme", value: true),
          Spacer(),
          Text("Reccuring Alarm - v0.01"),
        ]),
      ),
    );
  }
}
