import 'package:gallery_app/src/ui/app/app_bloc.dart';
import 'package:gallery_app/src/models/app/app_status.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, activeTab) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('This is Favorite Page'),
          ],
        ),
      );
    });
  }
}
