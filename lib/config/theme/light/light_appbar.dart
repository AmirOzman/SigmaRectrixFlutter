import 'package:flutter/material.dart';

import '../theme.dart';

AppBarTheme lightAppBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    backgroundColor: COLOR_2,
    shape: RoundedRectangleBorder(),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  );
}
