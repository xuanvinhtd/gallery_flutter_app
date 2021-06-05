import 'package:gallery_app/src/models/app/app_status.dart';
import 'package:gallery_app/src/models/app/app_tab.dart';
import 'package:gallery_app/src/ui/app/app_bloc.dart';
import 'package:gallery_app/src/ui/app/app_event.dart';

import 'package:gallery_app/src/ui/tabbar/favorite/favorite_page.dart';
import 'package:gallery_app/src/ui/tabbar/home/home_page.dart';
import 'package:gallery_app/src/ui/tabbar/search/search_page.dart';
import 'package:gallery_app/src/ui/tabbar/widgets/tab_selector.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget getBody(AppState appState) {
      if (appState is AppStart) {
        switch (appState.tab) {
          case AppTab.home:
            return HomePage();
          case AppTab.search:
            return SearchPage();
          case AppTab.favorite:
            return FavoritePage();
        }
        return HomePage();
      }
      return Container();
    }

    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      if (appState is AppStart) {
        var scaffold = Scaffold(
          appBar: AppBar(
            title: Text(
              'Tab Page',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: BlocProvider<AppBloc>(
            create: (context) => BlocProvider.of<AppBloc>(context),
            child: getBody(appState),
          ),
          bottomNavigationBar: TabSelector(
            appStart: appState,
            onTabSelected: (tab) => BlocProvider.of<AppBloc>(context)
                .add(AppUpdated(AppStart(tab: tab))),
          ),
        );
        return scaffold;
      }
      return Container();
    });
  }
}
