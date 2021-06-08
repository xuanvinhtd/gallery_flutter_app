import 'package:gallery_app/src/models/media/media_item.dart';

class GMediaItem {
  String id;
  String baseUrl;
  String filename;

  GMediaItem(this.id, this.baseUrl, this.filename);

  factory GMediaItem.fromJson(Map<String, dynamic> json) {
    return GMediaItem(
      json['id'] ?? '',
      json['baseUrl'] ?? '',
      json['filename'] ?? '',
    );
  }

  MediaItem mapToMediaItem() {
    return MediaItem(id: this.id, baseUrl: this.baseUrl, fileName: filename);
  }
}
