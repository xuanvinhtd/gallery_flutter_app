import 'package:gallery_app/src/models/app/app_status.dart';
import 'package:gallery_app/src/repository/api/app_repository.dart';
import 'package:gallery_app/src/ui/app/app_event.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository _appRepository;

  AppBloc(this._appRepository) : super(AppInitial());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppUpdated) {
      if (event.state is AppInitial) {
        await Future.delayed(Duration(seconds: 5));
        yield AppLoad();
      }
      if (event.state is AppLoad) {
        await _appRepository.fetchPosts();
        yield AppStart();
      }
      if (event.state is AppStart) {
        yield event.state;
      }
    }
  }
}
