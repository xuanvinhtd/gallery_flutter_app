import 'package:gallery_app/src/models/app/app_env.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppConfig {
  AppConfig({
    @required this.appName,
    @required this.env,
    @required this.apiBaseUrl,
  });

  final String appName;
  final AppEnv env;
  final String apiBaseUrl;
}
