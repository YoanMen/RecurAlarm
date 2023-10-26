// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class BoolSetting {
  final String name;
  final bool value;

  const BoolSetting(
    this.name,
    this.value,
  );

  @override
  String toString() => 'BoolSetting(name: $name, value: $value)';

  @override
  bool operator ==(covariant BoolSetting other) {
    if (identical(this, other)) return true;

    return other.name == name && other.value == value;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}
