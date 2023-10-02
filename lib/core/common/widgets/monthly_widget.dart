import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/common/widgets/segmented_selection_days.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';

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
            segments: const [
              ButtonSegment(
                value: 0,
                label: FittedBox(child: Text("Beginning")),
              ),
              ButtonSegment(
                value: 1,
                label: FittedBox(child: Text('Middle')),
              ),
              ButtonSegment(
                value: 2,
                label: FittedBox(child: Text("End")),
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
            segments: const [
              ButtonSegment(
                value: 0,
                label: FittedBox(child: Text('1 mois')),
              ),
              ButtonSegment(
                value: 1,
                label: FittedBox(child: Text('3 mois')),
              ),
              ButtonSegment(
                value: 2,
                label: FittedBox(child: Text('6 mois')),
              ),
              ButtonSegment(
                value: 3,
                label: FittedBox(child: Text('12 mois')),
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
