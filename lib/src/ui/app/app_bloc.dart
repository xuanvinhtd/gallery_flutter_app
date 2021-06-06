import 'package:gallery_app/src/models/app/app_status.dart';
import 'package:gallery_app/src/ui/app/app_event.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppUpdated) {
      if (event.state is AppInitial) {
        yield AppLoad();
      }
      if (event.state is AppLoad) {
        yield AppStart();
      }
      if (event.state is AppStart) {
        yield event.state;
      }
    }
  }
}
