import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/src/repository/api/app_repository.dart';
import 'package:gallery_app/src/ui/tabbar/cloud/cubit/cloud_state.dart';

class CloudCubit extends Cubit<CloudState> {
  CloudCubit({@required this.appRepository}) : super(CloudState.loading());
  final AppRepository? appRepository;

  Future<void> fetchAllMedia() async {}
  Future<void> fetchAllPhoto() async {}
  Future<void> fetchAllVideo() async {}
  Future<void> fetchAllAlbum() async {}
  Future<void> refreshData() async {}
}
