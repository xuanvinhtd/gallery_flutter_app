import 'package:flutter/material.dart';
import 'package:gallery_app/src/config/app_constant.dart';
import 'package:gallery_app/src/models/media/album_item.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:gallery_app/src/ui/preview/photo/photo_preview_page.dart';
import 'package:gallery_app/src/ui/widgets/gl_app_bar.dart';
import 'package:gallery_app/src/ui/widgets/gl_media.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaListPage extends StatelessWidget {
  const MediaListPage(this.album, {Key? key}) : super(key: key);
  final AlbumItem album;

  ThumbOption thumbMediaOption(int w) {
    return ThumbOption(
      width: w,
      height: w,
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: GLAppBar(
          title: album.name,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppConstant.mediaCrossAxisCount,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            final item = album.items[index];
            return GLMedia(
              item,
              thumbMediaOption((w ~/ AppConstant.mediaCrossAxisCount)),
              () => _onTapMedia(context, item),
            );
          },
          itemCount: album.items.length,
        ));
  }

  void _onTapMedia(BuildContext context, MediaItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhotoPreviewPage(item)),
    );
  }
}
