import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_app/src/helper/utility/lur_map.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:photo_manager/photo_manager.dart';

class GLMedia extends StatelessWidget {
  const GLMedia(
    this.item,
    this.thumbOption,
    this.onTap, {
    Key? key,
  }) : super(key: key);
  final MediaItem item;
  final Function() onTap;
  final ThumbOption thumbOption;

  @override
  Widget build(BuildContext context) {
    final file = item.assetsUrl;
    if (file == null || item.entity == null) return const SizedBox();

    if (item.entity?.type == AssetType.audio) {
      return Center(
        child: Icon(
          Icons.audiotrack,
          size: 30,
        ),
      );
    }
    final entity = item.entity;
    final size = thumbOption.width;
    final u8List = ImageLruCache.getData(entity!, size, thumbOption.format);

    if (u8List != null) {
      return _buildItemWidget(entity, u8List, size, context);
    } else {
      return FutureBuilder<Uint8List?>(
        future: entity.thumbDataWithOption(thumbOption),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            ImageLruCache.setData(
                entity, size, thumbOption.format, snapshot.data!);
            return _buildItemWidget(entity, snapshot.data!, size, context);
          }
          return Center(
              child: SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  )));
        },
      );
    }
  }

  Widget _buildItemWidget(
      AssetEntity entity, Uint8List uint8list, num size, BuildContext context) {
    if (entity.type == AssetType.video) {
      return _buildVideoWidget(entity, uint8list, size, context);
    }

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Image.memory(
        uint8list,
        width: size.toDouble(),
        height: size.toDouble(),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildVideoWidget(
      AssetEntity entity, Uint8List uint8list, num size, BuildContext context) {
    final now = Duration(seconds: 30);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    var twoDigitMinutes = twoDigits(now.inMinutes.remainder(60));
    var twoDigitSeconds = twoDigits(now.inSeconds.remainder(60));

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Stack(children: [
        Image.memory(
          uint8list,
          width: size.toDouble(),
          height: size.toDouble(),
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black54,
                    ],
                    stops: [
                      0.0,
                      1.0
                    ])),
          ),
          height: 25,
        ),
        Positioned(
            bottom: 3,
            right: 3,
            child: Text("$twoDigitMinutes:$twoDigitSeconds",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.white)))
      ]),
    );
  }
}
