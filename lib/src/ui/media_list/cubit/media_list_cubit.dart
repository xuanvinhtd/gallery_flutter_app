import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/src/models/media/album_item.dart';
import 'package:gallery_app/src/repository/api/app_repository.dart';
import 'package:gallery_app/src/ui/media_list/cubit/media_list_state.dart';

class MediaListCubit extends Cubit<MediaListState> {
  MediaListCubit({@required this.appRepository}) : super(MediaListState());
  final AppRepository? appRepository;

  File? imageFile;
  bool isInitValue = false;
  bool hasChange = false;

  bool _isCloud = false;

  AlbumItem? _album;

  bool get isCloud {
    return _isCloud;
  }

  void initData(AlbumItem ab, bool isCloud) {
    _album = ab;
    _isCloud = isCloud;
    emit(state.copyWith(isLoading: false, album: _album));
    if (_album != null && isCloud) {
      fetchMediaItem();
    }
  }

  void showLoading() {
    emit(state.copyWith(isLoading: true));
  }

  Future<void> addAPhotoToAlbum(
      File imageFile, Function(String?) callback) async {
    emit(state.copyWith(isLoading: true));

    final result =
        await appRepository?.uploadMediaItem(imageFile, _album?.id ?? '');
    if (result == null || result.data == null) {
      emit(state.copyWith(isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
      if (result.isSuccess()) {
        hasChange = true;
        fetchMediaItem();
        callback(null);
      } else {
        callback(result.message);
      }
    }
  }

  Future<void> fetchMediaItem({Function(String?)? callback}) async {
    if (_album == null) return;
    emit(state.copyWith(isLoading: true));
    final result = await appRepository?.fetchMeidItemOfAlbums(_album?.id ?? '');

    if (result == null || result.data == null || result.data?.isEmpty == true) {
      emit(state.copyWith(isLoading: false));
      if (callback != null) {
        callback(null);
      }
      return;
    }

    if (result.isSuccess()) {
      _album = _album?.copyWith(items: result.data);
      if (callback != null) {
        callback(null);
      }
      emit(state.copyWith(isLoading: false, album: _album));
    } else {
      if (callback != null) {
        callback(result.message);
      }
      emit(state.copyWith(isLoading: false));
    }
  }
}
