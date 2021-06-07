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

  AlbumItem? _album;

  void initData(AlbumItem ab) {
    _album = ab;
    emit(state.copyWith(isLoading: false, album: _album));
  }

  Future<void> addAPhotoToAlbum(Function(String?) callback) async {
    emit(state.copyWith(isLoading: true));

    final result = await appRepository?.uploadMediaItem(imageFile!);
    if (result == null || result.data == null) {
      emit(state.copyWith(isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
      if (result.isSuccess()) {
        callback(null);
      } else {
        callback(result.message);
      }
    }
  }

  // Future<void> fetchAllAlbum() async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await appRepository?.listAlbums();

  //   if (result == null || result.data == null || result.data?.isEmpty == true) {
  //     emit(state.copyWith(isLoading: false));
  //     return;
  //   }
  //   if (result.isSuccess()) {
  //     final ab = result.data?.map((e) => e.mapToGLAlbum()).toList();
  //     emit(state.copyWith(isLoading: false, albums: ab, mode: ViewMode.album));
  //   } else {
  //     emit(state.copyWith(isLoading: false));
  //   }
  // }
}
