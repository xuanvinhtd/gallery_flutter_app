import 'package:gallery_app/src/models/app/app_status.dart';
import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class AppUpdated extends AppEvent {
  final AppState state;

  const AppUpdated(this.state);

  @override
  List<Object> get props => [state];

  @override
  String toString() => 'AppUpdated { state: $state }';
}
