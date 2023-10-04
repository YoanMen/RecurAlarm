import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/domain/entities/reminder.dart';
import 'package:recurring_alarm/localization/string_hardcoded.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';

Future confirmatiomPopUp(
    {required BuildContext context,
    required WidgetRef ref,
    required VoidCallback confirmButton,
    required String title,
    required String content}) {
  return showDialog(
    context: context,
    builder: (
      context,
    ) {
      return AlertDialog.adaptive(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: confirmButton, child: Text("Yes".hardcoded)),
          TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text("No".hardcoded))
        ],
      );
    },
  );
}
