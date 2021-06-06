import 'package:gallery_app/src/models/media/media_item.dart';

class AlbumItem {
  final String? id;
  final String name;
  final String date;
  final int count;
  final List<MediaItem> items;
  const AlbumItem(
      {this.id,
      this.count = 0,
      this.date = '',
      this.name = '',
      this.items = const []});
}