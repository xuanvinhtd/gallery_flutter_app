import 'package:equatable/equatable.dart';
import 'package:gallery_app/src/models/media/album_item.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:gallery_app/src/models/view_mode.dart';

// ignore: must_be_immutable
class GalleryState extends Equatable {
  GalleryState(
      {this.mode = ViewMode.all_media,
      this.medias = const [],
      this.albums = const [],
      this.isLoading = true});

  ViewMode mode;
  bool isLoading;
  List<MediaItem> medias;
  List<AlbumItem> albums;

  @override
  List<Object> get props => [mode, isLoading, medias, albums];

  GalleryState.loading() : this(isLoading: true);

  GalleryState loadAllMedias(List<MediaItem> medias, ViewMode mode) => copyWith(
        mode: mode,
        medias: medias,
        isLoading: false,
      );
  GalleryState loadAllAlbums(List<AlbumItem> albums) =>
      copyWith(mode: ViewMode.album, albums: albums, isLoading: false);

  GalleryState copyWith(
      {ViewMode? mode,
      bool? isLoading,
      List<MediaItem>? medias,
      List<AlbumItem>? albums}) {
    return GalleryState(
        isLoading: isLoading ?? this.isLoading,
        mode: mode ?? this.mode,
        medias: medias ?? this.medias,
        albums: albums ?? this.albums);
  }
}
