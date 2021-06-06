import 'package:gallery_app/src/config/app_constant.dart';
import 'package:gallery_app/src/helper/localization/app_bloc_localization.dart';
import 'package:gallery_app/src/models/media/album_item.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:gallery_app/src/models/view_mode.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/src/ui/media_list/media_list_page.dart';
import 'package:gallery_app/src/ui/preview/photo/photo_preview_page.dart';
import 'package:gallery_app/src/ui/preview/video/video_preview_page.dart';
import 'package:gallery_app/src/ui/tabbar/gallery/bloc/gallery_cubit.dart';
import 'package:gallery_app/src/ui/tabbar/gallery/bloc/gallery_state.dart';
import 'package:gallery_app/src/ui/widgets/gl_album.dart';
import 'package:gallery_app/src/ui/widgets/gl_app_bar.dart';
import 'package:gallery_app/src/ui/widgets/gl_media.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GLAppBar(
        title: AppLocalization.of(context).gallery,
        actions: [_buildPopupMenu(context)],
      ),
      body: const _ListMedia(),
    );
  }

  Widget _buildPopupMenu(BuildContext context) {
    final theme = Theme.of(context);
    return PopupMenuButton<ViewMode>(
      offset: const Offset(0, 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      icon: Icon(
        Icons.more_vert,
        color: theme.primaryColor,
      ),
      elevation: 8,
      onSelected: (value) => _onViewModeChanged(context, value),
      itemBuilder: (BuildContext context) {
        final list = ViewMode.values
            .map((e) => PopupMenuItem(
                value: e,
                child: Text(
                  e.label(context),
                  style: theme.textTheme.subtitle1
                      ?.copyWith(color: theme.primaryColor),
                )))
            .toList();
        return list;
      },
    );
  }

  void _onViewModeChanged(BuildContext context, ViewMode? value) {
    final cubit = context.read<GalleryCubit>();
    switch (value) {
      case ViewMode.all_media:
        cubit.fetchAllMedia();
        break;
      case ViewMode.photo:
        cubit.fetchAllPhoto();
        break;
      case ViewMode.video:
        cubit.fetchAllVideo();
        break;
      case ViewMode.album:
        cubit.fetchAllAlbum();
        break;
      default:
        break;
    }
  }
}

class _ListMedia extends StatefulWidget {
  const _ListMedia({Key? key}) : super(key: key);

  @override
  __ListMediaState createState() => __ListMediaState();
}

class __ListMediaState extends State<_ListMedia> {
  final _scrollController = ScrollController();
  ThumbOption thumbMediaOption(int w) {
    return ThumbOption(
      width: w,
      height: w,
    );
  }

  @override
  Widget build(BuildContext context) {
    final galleyState = context.watch<GalleryCubit>().state;
    print("REBUIL");
    final data = dataSource(galleyState);
    if (galleyState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (data.isEmpty) {
      return Center(
        child: Image.asset(
          'assets/icon/empty_icon.png',
          scale: 3,
          color: Colors.grey,
        ),
      );
    }
    final w = MediaQuery.of(context).size.width;
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      gridDelegate: _currentSliverGridDelegate(galleyState.mode),
      itemBuilder: (context, index) {
        return _builItem(data, index, w.toInt(), context);
      },
      itemCount: data.length,
    );
  }

  List<dynamic> dataSource(GalleryState state) {
    if (state.mode.isAlbum) {
      return state.albums;
    }

    return state.medias;
  }

  Widget _builItem(List<dynamic> data, int index, int w, BuildContext context) {
    final item = data[index];
    if (item is AlbumItem) {
      return GLAlbum(
          item,
          thumbMediaOption((w ~/ AppConstant.albumCrossAxisCount)),
          () => _onTapAlbum(context, item));
    } else if (item is MediaItem) {
      return GLMedia(
        item,
        thumbMediaOption((w ~/ AppConstant.mediaCrossAxisCount)),
        () {
          _onTapMedia(context, item);
        },
      );
    }
    return const SizedBox();
  }

  SliverGridDelegateWithFixedCrossAxisCount _currentSliverGridDelegate(
      ViewMode mode) {
    if (mode == ViewMode.album) {
      return SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppConstant.albumCrossAxisCount,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 10 / 12);
    }
    return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppConstant.mediaCrossAxisCount,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5);
  }

  void _onTapMedia(BuildContext context, MediaItem item) async {
    String mediaUrl = '';
    if (item.entity?.type == AssetType.video) {
      mediaUrl = await item.entity?.getMediaUrl() ?? '';
    }
    print("VIND-> ${mediaUrl}");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => item.entity?.type == AssetType.image
              ? PhotoPreviewPage(item)
              : VideoPreview(item, mediaUrl)),
    );
  }

  void _onTapAlbum(BuildContext context, AlbumItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MediaListPage(item)),
    );
  }
}
