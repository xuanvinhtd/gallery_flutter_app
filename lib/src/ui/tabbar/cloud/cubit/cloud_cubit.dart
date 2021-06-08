import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/src/models/media/album_item.dart';
import 'package:gallery_app/src/models/view_mode.dart';
import 'package:gallery_app/src/repository/api/app_repository.dart';
import 'package:gallery_app/src/ui/app/app_manager.dart';
import 'package:gallery_app/src/ui/tabbar/cloud/cubit/cloud_state.dart';

class CloudCubit extends Cubit<CloudState> {
  CloudCubit({@required this.appRepository}) : super(CloudState.loading());
  final AppRepository? appRepository;
  final AppManager _appManager = AppManager();

  bool get isLoggedIn {
    return _appManager.isLoggedIn();
  }

  String albumTitle = '';

  void initData() {
    emit(state.copyWith(isLoggedIn: isLoggedIn));
    if (isLoggedIn) {
      fetchAllMedia();
    }
  }

  Future<void> signGoogle(Function(String?) callback) async {
    final result = await _appManager.signIn();
    if (result == null) {
      emit(state.copyWith(isLoading: false));
      callback("Không đặng nhập thành công!");
    } else {
      emit(state.copyWith(isLoading: false, isLoggedIn: true));
      fetchAllMedia();
      callback(null);
    }
  }

  Future<void> createAlnum(Function(String?, AlbumItem?) callback) async {
    emit(state.copyWith(isLoading: true));
    final result = await appRepository?.createAlbum(albumTitle);
    if (result == null || result.data == null) {
      emit(state.copyWith(isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
      if (result.isSuccess()) {
        callback(null, result.data?.mapToGLAlbum());
      } else {
        callback(result.message, null);
      }
    }
  }

  Future<void> fetchAllAlbum({Function(String?)? callback}) async {
    emit(state.copyWith(isLoading: true));
    final result = await appRepository?.listAlbums();

    if (result == null || result.data == null || result.data?.isEmpty == true) {
      emit(state.copyWith(isLoading: false));
      if (callback != null) {
        callback(null);
      }
      return;
    }
    if (result.isSuccess()) {
      final ab = result.data?.map((e) => e.mapToGLAlbum()).toList();
      if (callback != null) {
        callback(null);
      }
      emit(state.copyWith(isLoading: false, albums: ab, mode: ViewMode.album));
    } else {
      if (callback != null) {
        callback(result.message);
      }
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> fetchAllMedia({Function(String?)? callback}) async {
    emit(state.copyWith(isLoading: true));
    final result = await appRepository?.fetchMediaItems();

    if (result == null || result.data == null || result.data?.isEmpty == true) {
      emit(state.copyWith(isLoading: false));
      if (callback != null) {
        callback(null);
      }
      return;
    }
    if (result.isSuccess()) {
      if (callback != null) {
        callback(null);
      }
      emit(state.copyWith(
          isLoading: false, medias: result.data, mode: ViewMode.all_media));
    } else {
      if (callback != null) {
        callback(result.message);
      }
      emit(state.copyWith(isLoading: false));
    }
  }
}
