import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recurring_alarm/core/constant.dart';
import 'package:recurring_alarm/presentation/reminder/viewmodels/reminder_view_model.dart';

class ErrorValidatorText extends ConsumerWidget {
  const ErrorValidatorText({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          ref.watch(reminderViewModel).validatorErrorText,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.red, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
