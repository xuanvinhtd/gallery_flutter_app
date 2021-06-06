import 'package:flutter/material.dart';
import 'package:gallery_app/src/helper/localization/app_bloc_localization.dart';

enum ViewMode { all_media, photo, video, album }

extension ViewModeExt on ViewMode {
  String label(BuildContext context) {
    switch (this) {
      case ViewMode.all_media:
        return AppLocalization.of(context).allMedia;
      case ViewMode.photo:
        return AppLocalization.of(context).photos;
      case ViewMode.video:
        return AppLocalization.of(context).videos;
      case ViewMode.album:
        return AppLocalization.of(context).album;
      default:
        return "";
    }
  }

  bool get isAlbum {
    return this == ViewMode.album;
  }
}
