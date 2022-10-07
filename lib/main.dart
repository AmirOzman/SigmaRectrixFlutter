import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigma_crm/screen/screen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'config/theme/theme.dart';

void main() {
  // BlocOverrides.runZoned(
  //   () => runApp(
  //     const MyApp(),
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      //TODO added
      // initialRoute: initScreen == 0 || initScreen == null ? "first" : "/" OnBoarding(),,
      // routes: {},
      // home: const LoginScreen(),
      home: const Onboarding(),
    );
  }
}
