import 'dart:io';

import 'package:gallery_app/src/config/app_constant.dart';
import 'package:gallery_app/src/config/app_config.dart';
import 'package:gallery_app/src/models/app/app_env.dart';
import 'package:gallery_app/src/models/app/app_status.dart';
import 'package:gallery_app/src/repository/api/app_repository.dart';
import 'package:gallery_app/src/ui/app/app_bloc.dart';
import 'package:gallery_app/src/ui/app/app_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main.dart';

// To Run this file please.
// Setup file .vscode/launch.json -> "program": "lib/main_pro.dart",

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig(
    appName: 'App Template PRO',
    env: AppEnv.pro,
    apiBaseUrl: AppConstant.baseUrl,
  );

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  } else {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AppRepository(config.apiBaseUrl, config.env),
        ),
      ],
      child: BlocProvider<AppBloc>(
        create: (context) {
          return AppBloc(AppRepository(config.apiBaseUrl, config.env))
            ..add(AppUpdated(AppInitial()));
        },
        child: App(config),
      )));
}
