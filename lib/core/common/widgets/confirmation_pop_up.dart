import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          TextButton(
              onPressed: confirmButton,
              child: Text(AppLocalizations.of(context)!.yes)),
          TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.no))
        ],
      );
    },
  );
}
