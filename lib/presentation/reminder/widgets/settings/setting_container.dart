import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/presentation/settings/viewmodel/settings_viewmodel.dart';

class SettingContainer extends ConsumerWidget {
  const SettingContainer({
    Key? key,
    required this.settingName,
    required this.settingText,
    required this.value,
  }) : super(key: key);

  final String settingName;
  final String settingText;
  final bool value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(settingText),
            ),
            const SizedBox(
              width: kDefaultPadding,
            ),
            Switch.adaptive(
              value: value,
              onChanged: (e) {
                ref
                    .read(settingViewModel.notifier)
                    .saveBoolSetting(settingName, value);
              },
            )
          ],
        ),
      ),
    );
  }
}
