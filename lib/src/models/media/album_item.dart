import 'package:gallery_app/src/models/media/media_item.dart';

class AlbumItem {
  final String? id;
  final String name;
  final String date;
  final int count;
  final List<MediaItem> items;
  final String coverUrl;

  const AlbumItem(
      {this.id,
      this.count = 0,
      this.date = '',
      this.name = '',
      this.coverUrl = '',
      this.items = const []});

  AlbumItem copyWith(
      {String? id,
      String? name,
      String? date,
      int? count,
      List<MediaItem>? items,
      String? coverUrl}) {
    return AlbumItem(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
        count: count ?? this.count,
        items: items ?? this.items,
        coverUrl: coverUrl ?? this.coverUrl);
  }
}
