import 'package:flutter/material.dart';
import 'package:sigma_crm/config/theme/light/light_dialog.dart';
import 'light/light.dart';
import 'dark/dark.dart';

///light color scheme
const COLOR_PRIMARY_LIGHT = Color.fromRGBO(254, 205, 69, 1);
const COLOR_ACCENT_LIGHT = Color.fromRGBO(37, 104, 251, 1);

///dark color scheme
const COLOR_PRIMARY_DARK = Colors.red;
const COLOR_ACCENT_DARK = Colors.blue;

///monochrome blue
const COLOR_1 = Color.fromRGBO(15, 8, 75, 1);
const COLOR_2 = Color.fromRGBO(38, 64, 139, 1);
const COLOR_3 = Color.fromRGBO(61, 96, 167, 1);
const COLOR_4 = Color.fromRGBO(129, 177, 213, 1);
const COLOR_5 = Color.fromRGBO(160, 210, 231, 1);

///Theme selections
enum AppTheme {
  LightTheme,
  DarkTheme,
}

final appThemeData = {
  AppTheme.LightTheme: ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Avenir",
    brightness: Brightness.light,
    // fontFamily: "Open Sans",
    // hintColor: Colors.green,
    // dialogBackgroundColor: ,
    primaryColor: COLOR_PRIMARY_LIGHT,
    splashColor: COLOR_PRIMARY_DARK,
    dialogTheme: lightDialog(),
    textTheme: lightTextTheme(),
    appBarTheme: lightAppBarTheme(),
    bottomAppBarTheme: lightBottomAppbar(),
    sliderTheme: SliderThemeData(),
    elevatedButtonTheme: lightElevatedButton(),
    inputDecorationTheme: lightInputDecoration(),
    iconTheme: lightIcon(),
    bottomSheetTheme: lightBottomSheet(),
    snackBarTheme: lightSnackbar(),
    bannerTheme: lightBanner(),
    floatingActionButtonTheme: lightFloatingActionButton(),
    drawerTheme: lightDrawer(),
    tabBarTheme: lightTabBar(),
    cardTheme: lightCard(),
    textButtonTheme: lightTextButton(),
    listTileTheme: lightListTile(),
    timePickerTheme: lightTimePicker(),
    progressIndicatorTheme: lightProgressIndicator(),
    dividerTheme: lightDivider(),
  ),
  AppTheme.DarkTheme: ThemeData(),
};

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Avenir",
    brightness: Brightness.light,
    splashFactory: InkRipple.splashFactory,
    // fontFamily: "Open Sans",
    // hintColor: Colors.green,
    // dialogBackgroundColor: ,
    primaryColor: COLOR_PRIMARY_LIGHT,
    splashColor: COLOR_ACCENT_LIGHT,
    dialogTheme: lightDialog(),
    textTheme: lightTextTheme(),
    appBarTheme: lightAppBarTheme(),
    bottomAppBarTheme: lightBottomAppbar(),
    sliderTheme: SliderThemeData(),
    elevatedButtonTheme: lightElevatedButton(),
    inputDecorationTheme: lightInputDecoration(),
    iconTheme: lightIcon(),
    bottomSheetTheme: lightBottomSheet(),
    snackBarTheme: lightSnackbar(),
    bannerTheme: lightBanner(),
    floatingActionButtonTheme: lightFloatingActionButton(),
    drawerTheme: lightDrawer(),
    tabBarTheme: lightTabBar(),
    cardTheme: lightCard(),
    textButtonTheme: lightTextButton(),
    listTileTheme: lightListTile(),
    timePickerTheme: lightTimePicker(),
    progressIndicatorTheme: lightProgressIndicator(),
    dividerTheme: lightDivider(),
  );
}

class Orange {
  final orange1 = const Color(0xFFFF6200);
  final orange2 = const Color(0xFFFD7F2C);
  final orange3 = const Color(0xFFFD9346);
  final orange4 = const Color(0xFFFDA766);
  final orange5 = const Color(0xFFFDA766);
  const Orange();
}
