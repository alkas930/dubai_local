import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.blue));

//////dark theme
final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.amber,
    colorScheme: ColorScheme.dark(primaryContainer: Colors.blue));
