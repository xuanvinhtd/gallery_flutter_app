import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:gallery_app/src/ui/widgets/gl_app_bar.dart';

class PhotoPreviewPage extends StatelessWidget {
  const PhotoPreviewPage(this.item, {Key? key}) : super(key: key);
  final MediaItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GLAppBar(
        title: item.name,
      ),
      body: FutureBuilder<File?>(
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
