import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recurring_alarm/core/common/formatting_utils.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';
import 'package:recurring_alarm/theme/palette.dart';

class SelectDate extends ConsumerWidget {
  const SelectDate({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.beginDate,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(),
        GestureDetector(
            onTap: () async {
              final dateSelected = await showDatePicker(
                  context: context,
                  initialDate:
                      ref.read(reminderViewModel).beginDate ?? DateTime.now(),
                  firstDate: DateTime(DateTime.now().year - 20,
                      DateTime.now().month, DateTime.now().day),
                  lastDate: DateTime(DateTime.now().year + 100));

              if (dateSelected != null) {
                ref
                    .read(reminderViewModel.notifier)
                    .setDateSelected(dateSelected);
              }
            },
            child: Text(
              (ref.watch(reminderViewModel).beginDate != null)
                  ? formatDatetoString(
                      ref.read(reminderViewModel).beginDate!, context)
                  : AppLocalizations.of(context)!.tapHere,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Palette.primaryColor),
            ))
      ],
    );
  }
}
