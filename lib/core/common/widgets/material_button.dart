import 'package:flutter/material.dart';
import 'package:recurring_alarm/theme/palette.dart';

class ButtonMaterial extends StatelessWidget {
  final Widget? child;
  final double side;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;
  const ButtonMaterial.blue(
      {Key? key, required this.child, required this.onPressed})
      : backgroundColor = Palette.primaryColor,
        foregroundColor = Colors.white,
        side = 0,
        super(key: key);

  const ButtonMaterial.transparent(
      {Key? key, required this.child, required this.onPressed})
      : backgroundColor = Palette.scaffoldColor,
        foregroundColor = Colors.black,
        side = 1,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                side: BorderSide(width: side)),
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            textStyle: const TextStyle()),
        onPressed: onPressed,
        child: child);
  }
}
