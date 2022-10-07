import 'package:flutter/material.dart';
import 'package:sigma_crm/config/theme/theme.dart';

TabBarTheme lightTabBar() {
  return TabBarTheme(
    unselectedLabelColor: COLOR_1,
    labelColor: Colors.white,
    indicatorSize: TabBarIndicatorSize.tab,
    labelStyle: TextStyle(color: Colors.white),
    indicator: BoxDecoration(
      gradient: LinearGradient(colors: [
        COLOR_3, COLOR_3,
        // COLOR_5,
      ]),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
      color: COLOR_3,
    ),
  );
}
