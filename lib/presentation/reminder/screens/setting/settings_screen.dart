import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(leading: const BackButton(), title: const Text("Settings")),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("DESC OPTIO "),
            Switch.adaptive(
              value: true,
              onChanged: (value) {}, // toogle activate
            ),
          ],
        )
      ]),
    );
  }
}
