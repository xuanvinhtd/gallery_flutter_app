// ignore: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:gallery_app/src/models/media/album_item.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:gallery_app/src/models/view_mode.dart';

// ignore: must_be_immutable
class CloudState extends Equatable {
  CloudState(
      {this.mode = ViewMode.album,
      this.medias = const [],
      this.albums = const [],
      this.isLoading = true,
      this.isLoggedIn = false});

  ViewMode mode;
  bool isLoading;
  bool isLoggedIn;
  List<MediaItem> medias;
  List<AlbumItem> albums;

  @override
  List<Object> get props => [mode, isLoading, medias, albums];

  CloudState.loading() : this(isLoading: true);

  CloudState copyWith(
      {ViewMode? mode,
      bool? isLoading,
      bool? isLoggedIn,
      List<MediaItem>? medias,
      List<AlbumItem>? albums}) {
    return CloudState(
        isLoading: isLoading ?? this.isLoading,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        mode: mode ?? this.mode,
        medias: medias ?? this.medias,
        albums: albums ?? this.albums);
  }
}
