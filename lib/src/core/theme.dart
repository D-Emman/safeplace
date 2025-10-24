import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[50],
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(

      // TextStyle(fontSize: 16.0),
    ),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      // bodyText2: TextStyle(fontSize: 16.0),
    ),
  );
}
