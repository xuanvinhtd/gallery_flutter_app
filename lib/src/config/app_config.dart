import 'package:gallery_app/src/models/app/app_env.dart';

class AppConfig {
  AppConfig({
    this.appName,
    this.env = AppEnv.dev,
    this.apiBaseUrl = '',
  });

  final String? appName;
  final AppEnv env;
  final String apiBaseUrl;
}
