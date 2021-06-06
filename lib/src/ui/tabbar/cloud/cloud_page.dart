import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/src/helper/localization/app_bloc_localization.dart';
import 'package:gallery_app/src/models/media/album_item.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:gallery_app/src/models/view_mode.dart';
import 'package:gallery_app/src/ui/tabbar/cloud/cubit/cloud_cubit.dart';
import 'package:gallery_app/src/ui/tabbar/cloud/cubit/cloud_state.dart';
import 'package:gallery_app/src/ui/widgets/gl_app_bar.dart';

class CloudPage extends StatelessWidget {
  const CloudPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GLAppBar(
        title: AppLocalization.of(context).cloud,
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
      onSelected: (value) => _onViewModeChanged(value),
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

  void _onViewModeChanged(ViewMode? value) {
    switch (value) {
      case ViewMode.all_media:
        break;
      case ViewMode.photo:
        break;
      case ViewMode.video:
        break;
      case ViewMode.album:
        break;
      default:
        break;
    }
  }
}

class _ListMedia extends StatelessWidget {
  const _ListMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final galleyState = context.watch<CloudCubit>().state;
    final data = dataSource(galleyState);
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      gridDelegate: _currentSliverGridDelegate(galleyState.mode),
      itemBuilder: (context, index) {
        return _builItem(data, index);
      },
      itemCount: data.length,
    );
  }

  List<dynamic> dataSource(CloudState state) {
    if (state.mode.isAlbum) {
      return state.albums;
    }
    return state.medias;
  }

  Widget _builItem(List<dynamic> data, int index) {
    final item = data[index];
    if (item is AlbumItem) {
      return SizedBox(); //GLAlbum(item);
    } else if (item is MediaItem) {
      return SizedBox(); //GLMedia(item);
    }
    return const SizedBox();
  }

  SliverGridDelegateWithFixedCrossAxisCount _currentSliverGridDelegate(
      ViewMode mode) {
    if (mode == ViewMode.album) {
      return SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 10 / 12);
    }
    return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5);
  }
}
