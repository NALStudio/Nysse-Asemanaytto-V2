import 'package:flutter/material.dart';

abstract class SettingsForm {
  String get displayName;
  Color get displayColor;

  Widget build(BuildContext context);
}
