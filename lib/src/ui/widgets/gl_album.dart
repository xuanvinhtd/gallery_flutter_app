import 'package:flutter/material.dart';
import 'package:gallery_app/src/helper/localization/app_bloc_localization.dart';
import 'package:gallery_app/src/models/media/album_item.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:gallery_app/src/ui/widgets/gl_media.dart';
import 'package:photo_manager/photo_manager.dart';

class GLAlbum extends StatelessWidget {
  const GLAlbum(
    this.item,
    this.thumbOption,
    this.onTap, {
    Key? key,
  }) : super(key: key);
  final AlbumItem? item;
  final ThumbOption? thumbOption;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GLMedia(
              item?.items.isEmpty == true ? null : item?.items.first,
              thumbOption,
              () {
                onTap();
              },
              coverPhoto: item?.coverUrl,
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(item?.name ?? '',
              style: Theme.of(context).textTheme.subtitle1),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
              '${item?.count ?? 0} ${AppLocalization.of(context).items}',
              style: Theme.of(context).textTheme.subtitle2),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
