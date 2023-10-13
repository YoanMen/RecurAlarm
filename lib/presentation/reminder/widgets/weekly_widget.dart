import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/segmented_selection_days.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeeklyWidget extends ConsumerWidget {
  const WeeklyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminderProviderWatch = ref.watch(reminderViewModel);
    final reminderProviderRead = ref.read(reminderViewModel.notifier);

    return Column(children: [
      const SizedBox(
        height: kDefaultPadding,
      ),
      const SegmentedSelectionDays(),
      const SizedBox(
        height: kDefaultPadding,
      ),
      SizedBox(
        width: double.infinity,
        child: SegmentedButton(
            emptySelectionAllowed: false,
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: 0,
                label: FittedBox(
                    child: Text(AppLocalizations.of(context)!.oneWeek)),
              ),
              ButtonSegment(
                value: 1,
                label: FittedBox(
                    child: Text(AppLocalizations.of(context)!.twoWeeks)),
              ),
              ButtonSegment(
                value: 2,
                label: FittedBox(
                    child: Text(AppLocalizations.of(context)!.treeWeeks)),
              ),
            ],
            onSelectionChanged: (Set<int> newSelection) {
              reminderProviderRead.setlenghtSelected(newSelection.first);
            },
            selected: <int>{reminderProviderWatch.lenghtBetweenReminder}),
      ),
    ]);
  }
}
