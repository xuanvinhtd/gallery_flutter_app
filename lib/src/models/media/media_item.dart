import 'dart:io';

import 'package:photo_manager/photo_manager.dart';

class MediaItem {
  final AssetEntity? entity;

  const MediaItem({this.entity});

  Future<File?>? get assetsUrl {
    return entity?.file;
  }

  String? get name {
    return entity?.title;
  }
}
