import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:gallery_app/src/ui/widgets/gl_app_bar.dart';

class PhotoPreviewPage extends StatelessWidget {
  const PhotoPreviewPage(this.item, {Key? key, this.isCloud = false})
      : super(key: key);
  final MediaItem item;
  final bool isCloud;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GLAppBar(
        isEnableBackButton: true,
        title: item.name,
      ),
      body: isCloud
          ? Container(
              width: double.infinity,
              height: double.infinity,
              child: CachedNetworkImage(
                imageUrl: '${item.baseUrl ?? ''}=w500',
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Center(
                      child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)));
                },
                errorWidget: (context, url, error) {
                  return const Icon(Icons.error);
                },
              ),
            )
          : FutureBuilder<File?>(
              future: item.assetsUrl,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  return Image.file(
                    snapshot.data!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.contain,
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
    );
  }
}
