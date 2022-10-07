import 'package:flutter/material.dart';
import 'package:sigma_crm/config/theme/theme.dart';

ElevatedButtonThemeData lightElevatedButton() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: COLOR_3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}
