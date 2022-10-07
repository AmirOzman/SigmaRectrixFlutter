import 'package:flutter/material.dart';
import 'package:sigma_crm/config/theme/theme.dart';

InputDecorationTheme lightInputDecoration() {
  return InputDecorationTheme(
    suffixIconColor: Colors.blue[200],
    prefixIconColor: Colors.blue[200],
    labelStyle: TextStyle(
      color: Colors.black45,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: COLOR_2),
    ),
  );
}
