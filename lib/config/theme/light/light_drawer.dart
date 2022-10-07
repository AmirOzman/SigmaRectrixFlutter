import 'package:flutter/material.dart';

DrawerThemeData lightDrawer() {
  return DrawerThemeData(
    elevation: 20,
    scrimColor: Colors.black54,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      ),
    ),
  );
}
