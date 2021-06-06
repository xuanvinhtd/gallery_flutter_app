// ignore: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:gallery_app/src/models/media/album_item.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:gallery_app/src/models/view_mode.dart';

// ignore: must_be_immutable
class CloudState extends Equatable {
  CloudState(
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

  CloudState.loading() : this(isLoading: true);

  CloudState.loadAllMedias(List<MediaItem> medias)
      : this(mode: ViewMode.all_media, medias: medias, isLoading: false);
  CloudState.loadAllAlbums(List<AlbumItem> albums)
      : this(mode: ViewMode.album, albums: albums, isLoading: false);
  CloudState.loadAllPhotos(List<MediaItem> medias)
      : this(mode: ViewMode.photo, medias: medias, isLoading: false);
  CloudState.loadAllVideos(List<MediaItem> medias)
      : this(mode: ViewMode.video, medias: medias, isLoading: false);

  CloudState copyWith(
      {ViewMode? mode,
      bool? isLoading,
      List<MediaItem>? medias,
      List<AlbumItem>? albums}) {
    return CloudState(
        isLoading: isLoading ?? this.isLoading,
        mode: mode ?? this.mode,
        medias: medias ?? this.medias,
        albums: albums ?? this.albums);
  }
}
