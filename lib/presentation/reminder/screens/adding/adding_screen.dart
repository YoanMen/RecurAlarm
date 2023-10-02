import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recurring_alarm/core/common/formatting_utils.dart';
import 'package:recurring_alarm/core/common/widgets/material_button.dart';
import 'package:recurring_alarm/core/common/widgets/monthly_widget.dart';
import 'package:recurring_alarm/core/common/widgets/reminder_type_selection.dart';
import 'package:recurring_alarm/core/common/widgets/text_form_field_material.dart';
import 'package:recurring_alarm/core/common/widgets/weekly_widget.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/localization/string_hardcoded.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';
import 'package:recurring_alarm/theme/palette.dart';

Future showReminderBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    enableDrag: true,
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (context, ref, child) {
          final reminderViewModelWatch = ref.watch(reminderViewModel);
          final reminderViewModelRead = ref.read(reminderViewModel.notifier);

          return Container(
            height: 700,
            width: double.infinity,
            padding: const EdgeInsets.only(
                left: 24, right: 24, top: kDefaultPadding),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "New reminder".hardcoded,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                TextFormFieldMaterial(
                  onChanged: (value) =>
                      reminderViewModelRead.updateText(value!),
                  labelText: "Task".hardcoded,
                  initialValue: reminderViewModelWatch.description,
                  maxLength: 80,
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                const ReminderTypeSelection(),
                switch (ref.watch(reminderViewModel).reminderType) {
                  ReminderType.daily => const SizedBox(),
                  ReminderType.weekly => const WeeklyWidget(),
                  ReminderType.monthly => const MonthlyWidget(),
                },
                Expanded(
                  child: Column(children: [
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    Row(
                      children: [
                        Text(
                          "Begin date",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () async {
                              final dateSelected = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      ref.read(reminderViewModel).beginDate ??
                                          DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime(DateTime.now().year + 100));

                              if (dateSelected != null) {
                                reminderViewModelRead
                                    .setDateSelected(dateSelected);
                              }
                            },
                            child: Text(
                              (reminderViewModelWatch.beginDate != null)
                                  ? formatDatetoString(
                                      ref.read(reminderViewModel).beginDate!)
                                  : "Tap here".hardcoded,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Palette.primaryColor),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    Row(
                      children: [
                        Text(
                          "Reminder time",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () async {
                              final timeSelected = await showTimePicker(
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child!,
                                    );
                                  },
                                  context: context,
                                  initialTime:
                                      ref.read(reminderViewModel).time ??
                                          const TimeOfDay(hour: 8, minute: 0));

                              if (timeSelected != null) {
                                reminderViewModelRead
                                    .setTimeSelected(timeSelected);
                              }
                            },
                            child: Text(
                              (ref.read(reminderViewModel).time == null)
                                  ? "Tap here".hardcoded
                                  : formatTimeToString(
                                      ref.read(reminderViewModel).time!),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Palette.primaryColor),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: ButtonMaterial.blue(
                              child: const Text("Add"),
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
                              child: const Text("Cancel"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                  ]),
                )
              ],
            ),
          );
        },
      );
    },
  );
}
