import 'package:gallery_app/src/models/media/album_item.dart';

class GAlbum {
  String id;
  String title;
  String productUrl;
  bool isWriteable;
  String mediaItemsCount;
  String coverPhotoBaseUrl;
  String coverPhotoMediaItemId;

  GAlbum(this.id, this.title, this.productUrl, this.isWriteable,
      this.mediaItemsCount, this.coverPhotoBaseUrl, this.coverPhotoMediaItemId);

  factory GAlbum.fromJson(Map<String, dynamic> json) {
    return GAlbum(
      json['id'] ?? '',
      json['title'] ?? '',
      json['productUrl'] ?? '',
      json['isWriteable'] ?? false,
      json['mediaItemsCount'] ?? '',
      json['coverPhotoBaseUrl'] ?? '',
      json['coverPhotoMediaItemId'] ?? '',
    );
  }
  AlbumItem mapToGLAlbum() {
    print('TITLE-> ${this.title}');
    return AlbumItem(
        id: this.id,
        count: this.mediaItemsCount.isNotEmpty
            ? int.parse(this.mediaItemsCount)
            : 0,
        name: this.title,
        coverUrl: this.coverPhotoBaseUrl,
        items: []);
  }
}
