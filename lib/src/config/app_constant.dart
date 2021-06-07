import 'package:flutter/material.dart';

class AppConstant {
  static final locales = const [Locale('vi'), Locale('en')];

  static final int kPeriodTimeClick = 2; //s

  static final int mediaCrossAxisCount = 3;
  static final int albumCrossAxisCount = 2;

  // Google
  static final List<String> scopes = [
    'profile',
    'https://www.googleapis.com/auth/photoslibrary',
    'https://www.googleapis.com/auth/photoslibrary.sharing'
  ];

// URL config
  static final baseDevUrl = 'https://photoslibrary.googleapis.com/v1';
  static final baseStgUrl = 'https://photoslibrary.googleapis.com/v1';
  static final baseProd = 'https://photoslibrary.googleapis.com/v1';

  static final albumPath = '/albums';
  static final uploadImagePath = '/uploads';
}
