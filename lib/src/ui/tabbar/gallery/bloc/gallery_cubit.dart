import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/src/models/media/album_item.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:gallery_app/src/models/view_mode.dart';
import 'package:gallery_app/src/ui/tabbar/gallery/bloc/gallery_state.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryState.loading());
  List<AssetPathEntity> _assetPathEntitys = [];

  void _reset() {
    _assetPathEntitys.clear();
  }

  Future<void> initData() async {
    await _fetchAll(ViewMode.all_media, isInit: true);
  }

  Future<void> fetchAllMedia() async {
    await _fetchAll(ViewMode.all_media);
  }

  Future<void> fetchAllPhoto() async {
    await _fetchAll(ViewMode.photo);
  }

  Future<void> fetchAllVideo() async {
    await _fetchAll(ViewMode.video);
  }

  Future<void> fetchAllAlbum() async {
    await _fetchAll(ViewMode.album);
  }

  Future<void> _fetchAll(ViewMode mode, {bool isInit = false}) async {
    if (state.mode == mode && !isInit) return;
    _loading();
    RequestType type = RequestType.common;
    bool onlyAll = true;
    switch (mode) {
      case ViewMode.all_media:
        type = RequestType.all;
        break;
      case ViewMode.photo:
        type = RequestType.image;
        break;
      case ViewMode.video:
        type = RequestType.video;
        break;
      case ViewMode.album:
        onlyAll = false;
        type = RequestType.all;
        break;
      default:
        break;
    }

    final paths = await _fetchData(onlyAll: onlyAll, type: type);
    _reset();
    if (mode == ViewMode.album) {
      List<AlbumItem> albums = [];
      await Future.forEach(paths, (element) async {
        final path = element as AssetPathEntity;
        final assetList = await path.assetList;

        PhotoCachingManager().requestCacheAssets(
          assets: assetList,
        );

        final medias = assetList.map((e) => MediaItem(entity: e)).toList();
        final ab = AlbumItem(
            id: path.id, name: path.name, count: medias.length, items: medias);
        albums.add(ab);
      });
      emit(state.loadAllAlbums(albums));
    } else {
      if (paths.isNotEmpty) {
        final album = paths.first;
        if (album.assetCount != 0) {
          final assetList = await album.assetList;
          final medias = assetList.map((e) => MediaItem(entity: e)).toList();
          emit(state.loadAllMedias(medias, mode));
          return;
        }
      }
      emit(state.loadAllMedias([], mode));
    }
  }

  Future<List<AssetPathEntity>> _fetchData(
      {bool onlyAll = false, RequestType type = RequestType.common}) async {
    final isPermitted = await PhotoManager.requestPermissionExtend();
    if (PermissionState.authorized == isPermitted) {
      emit(state.copyWith(notPermission: false));
      return await PhotoManager.getAssetPathList(onlyAll: onlyAll, type: type);
    } else {
      emit(state.copyWith(notPermission: true, isLoading: false));
      return [];
    }
  }

  void _loading({bool isLoading = true}) {
    emit(state.copyWith(isLoading: isLoading));
  }
}
