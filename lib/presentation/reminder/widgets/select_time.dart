import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';
import 'package:recurring_alarm/theme/palette.dart';

class SelectTime extends ConsumerWidget {
  const SelectTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.reminderTime,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(),
        GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();

              final timeSelected = await showTimePicker(
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context),
                      child: child!,
                    );
                  },
                  context: context,
                  initialTime: ref.read(reminderViewModel).time ??
                      const TimeOfDay(hour: 8, minute: 0));

              if (timeSelected != null) {
                ref
                    .read(reminderViewModel.notifier)
                    .setTimeSelected(timeSelected);
              }
            },
            child: Text(
              (ref.watch(reminderViewModel).time == null)
                  ? AppLocalizations.of(context)!.tapHere
                  : ref.read(reminderViewModel).time!.format(context),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Palette.primaryColor),
            ))
      ],
    );
  }
}
