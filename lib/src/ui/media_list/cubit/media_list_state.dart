import 'package:equatable/equatable.dart';
import 'package:gallery_app/src/models/media/album_item.dart';

// ignore: must_be_immutable
class MediaListState extends Equatable {
  MediaListState({
    this.album = const AlbumItem(),
    this.isLoading = true,
  });

  bool isLoading;
  AlbumItem album;

  @override
  List<Object> get props => [album, isLoading];

  MediaListState copyWith({bool? isLoading, AlbumItem? album}) {
    return MediaListState(
        isLoading: isLoading ?? this.isLoading, album: album ?? this.album);
  }
}
