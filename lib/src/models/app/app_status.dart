import 'package:gallery_app/src/models/app/app_tab.dart';

abstract class AppState {
  const AppState();
}

class AppInitial extends AppState {
  const AppInitial();
}

class AppStart extends AppState {
  final AppTab tab;
  const AppStart({this.tab = AppTab.home});
}

class AppLoad extends AppState {
  const AppLoad();
}
