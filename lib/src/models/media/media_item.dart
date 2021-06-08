import 'dart:io';

import 'package:photo_manager/photo_manager.dart';

class MediaItem {
  final AssetEntity? entity;

  final String? id;
  final String? fileName;
  final String? baseUrl;

  const MediaItem({this.id, this.entity, this.baseUrl, this.fileName});

  Future<File?>? get assetsUrl {
    return entity?.file;
  }

  String? get name {
    return entity?.title;
  }
}
