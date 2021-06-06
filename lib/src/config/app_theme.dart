import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.orange,
    primaryColor: Colors.orange,
    backgroundColor: Colors.white,
    accentColor: Color(0xFFE74C3C),
    primaryColorDark: Colors.black,
    dividerColor: Colors.black12,
    appBarTheme: AppBarTheme(
        color: Colors.white,
        titleTextStyle: TextStyle(color: Colors.orange, fontSize: 20)),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.black, fontSize: 20),
        subtitle1: TextStyle(color: Colors.black, fontSize: 16),
        subtitle2: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300)));

ThemeData dartThemeData = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.orange,
    primaryColor: Color(0xFFE74C3C),
    backgroundColor: Colors.grey[800],
    accentColor: Color(0xFFE74C3C),
    primaryColorDark: Colors.white,
    dividerColor: Colors.white12,
    appBarTheme: AppBarTheme(color: Colors.grey[900]),
    textTheme:
        TextTheme(bodyText1: TextStyle(color: Colors.black, fontSize: 20)));
