import 'package:gallery_app/src/models/app/app_status.dart';
import 'package:gallery_app/src/ui/app/app_bloc.dart';
import 'package:gallery_app/src/ui/app/app_event.dart';
import 'package:gallery_app/src/ui/tabbar/cloud/cloud_page.dart';
import 'package:gallery_app/src/ui/tabbar/gallery/gallery_page.dart';

import 'package:gallery_app/src/ui/tabbar/widgets/tab_selector.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      if (appState is AppStart) {
        var scaffold = Scaffold(
          body: IndexedStack(
            children: [const GalleryPage(), const CloudPage()],
            index: appState.tab.index,
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
