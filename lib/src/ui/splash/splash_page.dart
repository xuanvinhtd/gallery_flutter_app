import 'package:gallery_app/src/models/app/app_status.dart';
import 'package:gallery_app/src/ui/app/app_bloc.dart';
import 'package:gallery_app/src/ui/app/app_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(listener: (context, state) {
      if (state is AppLoad) {
        BlocProvider.of<AppBloc>(context).add(AppUpdated(AppLoad()));
      }
    }, child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Scaffold(
        body: Center(
          child: state is AppStart
              ? Text('Gallery')
              : const CircularProgressIndicator(),
        ),
      );
    }));
  }
}
