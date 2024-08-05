// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFormFieldMaterial extends StatelessWidget {
  final Function(String text)? onFieldSubmitted;
  final String? Function(String? value)? validator;
  final String? Function(String? value)? onSaved;

  final String? Function(String? value)? onChanged;

  final Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String labelText;
  final String? initialValue;
  final int? maxLength;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;

  const TextFormFieldMaterial({
    Key? key,
    required this.labelText,
    this.maxLength,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.onEditingComplete,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.initialValue,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = false,
    this.onChanged,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      maxLength: maxLength,
      textInputAction: textInputAction,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      obscureText: obscureText,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      initialValue: initialValue,
      decoration: InputDecoration(
          disabledBorder: const OutlineInputBorder(borderSide: BorderSide()),
          border: const OutlineInputBorder(borderSide: BorderSide()),
          labelText: labelText),
    );
  }
}
