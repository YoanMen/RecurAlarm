import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/common/widgets/material_button.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/error_validator_text.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/monthly_widget.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/reminder_type_selection.dart';
import 'package:recurring_alarm/core/common/widgets/text_form_field_material.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/select_date.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/select_time.dart';
import 'package:recurring_alarm/presentation/reminder/widgets/weekly_widget.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';

Future addReminderBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    isDismissible: true,
    enableDrag: true,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (context, ref, child) {
          final reminderViewModelWatch = ref.watch(reminderViewModel);
          final reminderViewModelRead = ref.read(reminderViewModel.notifier);

          return Container(
              height: MediaQuery.of(context).size.height / 1.3,
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 24, bottom: 10),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context)!.newReminder,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        if (reminderViewModelWatch
                            .validatorErrorText.isNotEmpty)
                          const ErrorValidatorText(),
                        TextFormFieldMaterial(
                          onChanged: (value) =>
                              reminderViewModelRead.updateText(value!),
                          labelText: AppLocalizations.of(context)!.task,
                          initialValue: reminderViewModelWatch.description,
                          maxLength: 80,
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        const ReminderTypeSelection(),
                        switch (ref.watch(reminderViewModel).reminderType) {
                          ReminderType.daily => const SizedBox.shrink(),
                          ReminderType.weekly => const WeeklyWidget(),
                          ReminderType.monthly => const MonthlyWidget(),
                        },
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        const SelectDate(),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        const SelectTime(),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: ButtonMaterial.blue(
                                child: Text(AppLocalizations.of(context)!.save),
                                onPressed: () => reminderViewModelRead
                                    .checkIfvalidate(context),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              width: 100,
                              child: ButtonMaterial.transparent(
                                child:
                                    Text(AppLocalizations.of(context)!.cancel),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ));
        },
      );
    },
  );
}
