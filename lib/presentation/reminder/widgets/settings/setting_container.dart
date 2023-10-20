import 'package:flutter/material.dart';
import 'package:recurring_alarm/core/constant.dart';

class SettingContainer extends StatelessWidget {
  const SettingContainer({
    Key? key,
    required this.settingText,
    required this.value,
  }) : super(key: key);

  final String settingText;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            onChanged: (e) {},
          )
        ],
      ),
    );
  }
}
