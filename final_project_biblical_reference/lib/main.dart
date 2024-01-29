import 'package:flutter/material.dart';
import 'package:final_project_biblical_reference/screens/home_screen.dart';

import 'package:final_project_biblical_reference/common/strings.dart'
    as strings;

void main() {
  runApp(const BiblicalReferenceApp());
}

class BiblicalReferenceApp extends StatelessWidget {
  const BiblicalReferenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: strings.appName,

      //Application theme
      theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF00ADB5),
            onPrimary: Colors.white,
            secondary: Color(0xFF393E46),
            onSecondary: Colors.white,
          )),

      //The home screen of the app
      home: const HomeScreen(),
    );
  }
}
