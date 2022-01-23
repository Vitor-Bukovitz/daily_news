import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  fontFamily: 'WorkSans',
  textTheme: const TextTheme(
    headline6: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: const ColorScheme(
    primary: Colors.white,
    primaryVariant: Colors.white,
    secondary: Colors.black,
    secondaryVariant: Color(0xfff3de69),
    surface: Colors.black,
    background: Colors.white,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Color(0xfff3de69),
    onSurface: Colors.black,
    onBackground: Colors.white,
    onError: Colors.red,
    brightness: Brightness.light,
  ),
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.black,
    labelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
  ),
);

final darkTheme = ThemeData(
  fontFamily: 'WorkSans',
  textTheme: const TextTheme(
    headline6: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: const ColorScheme(
    primary: Color(0xff1A1A1A),
    primaryVariant: Color(0xff1A1A1A),
    secondary: Colors.white,
    secondaryVariant: Color(0xfff3de69),
    surface: Colors.white,
    background: Color(0xff1A1A1A),
    error: Colors.red,
    onPrimary: Color(0xff1A1A1A),
    onSecondary: Color(0xfff3de69),
    onSurface: Colors.white,
    onBackground: Color(0xff1A1A1A),
    onError: Colors.red,
    brightness: Brightness.dark,
  ),
  backgroundColor: const Color(0xff1A1A1A),
  scaffoldBackgroundColor: const Color(0xff1A1A1A),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff1A1A1A),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.white,
    labelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
  ),
);
