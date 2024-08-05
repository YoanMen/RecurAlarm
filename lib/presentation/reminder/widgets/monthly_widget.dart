import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/segmented_selection_days.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MonthlyWidget extends ConsumerWidget {
  const MonthlyWidget({
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
                label:
                    FittedBox(child: Text(AppLocalizations.of(context)!.begin)),
              ),
              ButtonSegment(
                value: 1,
                label: FittedBox(
                    child: Text(AppLocalizations.of(context)!.middle)),
              ),
              ButtonSegment(
                value: 2,
                label:
                    FittedBox(child: Text(AppLocalizations.of(context)!.end)),
              ),
            ],
            onSelectionChanged: (Set<int> newSelection) {
              reminderProviderRead.setWhenMounthSelected(newSelection.first);
            },
            selected: <int>{reminderProviderWatch.whenInMonth}),
      ),
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
                    child: Text(AppLocalizations.of(context)!.oneMonth)),
              ),
              ButtonSegment(
                value: 1,
                label: FittedBox(
                    child: Text(AppLocalizations.of(context)!.treeMonth)),
              ),
              ButtonSegment(
                value: 2,
                label: FittedBox(
                    child: Text(AppLocalizations.of(context)!.sixMonth)),
              ),
              ButtonSegment(
                value: 3,
                label: FittedBox(
                    child: Text(AppLocalizations.of(context)!.twelveMonth)),
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
