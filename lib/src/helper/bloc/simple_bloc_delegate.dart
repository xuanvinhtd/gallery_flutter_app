// We can extend `BlocObserver` and override `onTransition` and `onError`
// in order to handle transitions and errors from all Blocs.
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print('BLOC EVENT: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('BLOC TRANSITION: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    print('BLOC ERROR: $error');
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onCreate(BlocBase cubit) {
    super.onCreate(cubit);
    print('BLOC CREATE: ${cubit.runtimeType}');
  }

  @override
  void onChange(BlocBase cubit, Change change) {
    super.onChange(cubit, change);
    print('BLOC ONCHANGE CUBIT: ${cubit.runtimeType} change:  $change');
  }

  @override
  void onClose(BlocBase cubit) {
    super.onClose(cubit);
    print('BLOC ONCLOSE CUBIT: ${cubit.runtimeType}');
  }
}
