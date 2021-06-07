import 'package:gallery_app/src/config/app_constant.dart';
import 'package:gallery_app/src/config/app_config.dart';
import 'package:gallery_app/src/config/app_routes.dart';
import 'package:gallery_app/src/models/app/app_status.dart';
import 'package:gallery_app/src/helper/localization/app_bloc_localization.dart';
import 'package:gallery_app/src/repository/api/app_repository.dart';
import 'package:gallery_app/src/ui/app/app_bloc.dart';
import 'package:gallery_app/src/ui/media_list/cubit/media_list_cubit.dart';
import 'package:gallery_app/src/ui/media_list/media_list_page.dart';
import 'package:gallery_app/src/ui/splash/splash_page.dart';

import 'package:gallery_app/src/config/app_theme.dart';
import 'package:gallery_app/src/ui/tabbar/tab/tab_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  final AppConfig config;

  App(this.config);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AppConfig get _config => widget.config;
  late AppBlocLocalizationsDelegate _appBlocLocalizationsDelegate;

  @override
  void initState() {
    super.initState();
    _appBlocLocalizationsDelegate = AppBlocLocalizationsDelegate();
    _appBlocLocalizationsDelegate.forceLocale =
        AppConstant.locales[1]; // I force en language
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _config.appName ?? '',
      theme: lightThemeData,
      darkTheme: dartThemeData,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        _appBlocLocalizationsDelegate
      ],
      supportedLocales: AppConstant.locales,
      routes: {
        AppRoutes.home: (context) {
          return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
            if (state is AppStart) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<AppBloc>(
                    create: (context) => BlocProvider.of<AppBloc>(context),
                  )
                ],
                child: TabPage(),
              );
            }
            return SplashPage();
          });
        },
        AppRoutes.media_list_page: (context) {
          return BlocProvider<MediaListCubit>(
            create: (context) => MediaListCubit(
                appRepository: RepositoryProvider.of<AppRepository>(context)),
            child: MediaListPage(),
          );
        }
      },
    );
  }
}
