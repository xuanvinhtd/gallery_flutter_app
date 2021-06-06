import 'package:flutter/material.dart';

class AppConstant {
  static final locales = const [Locale('vi'), Locale('en')];

  static final int kMasterDBVersion = 0;

  static final int mediaCrossAxisCount = 3;
  static final int albumCrossAxisCount = 2;

//URL config
  static final baseDevUrl = 'https://jsonplaceholder.typicode.com';
  static final baseStgUrl = 'https://jsonplaceholder.typicode.com';
  static final baseProd = 'https://jsonplaceholder.typicode.com';
  static final todoPath = '/todos/';
}
