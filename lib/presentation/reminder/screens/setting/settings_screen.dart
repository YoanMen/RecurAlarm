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
          SettingContainer(settingText: "Setting 1", value: true),
          SettingContainer(settingText: "Setting 2", value: true),
          SettingContainer(settingText: "Setting 3", value: true),
          Spacer(),
          Text("v0.01"),
        ]),
      ),
    );
  }
}

test(bool) {}
