import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/src/config/app_constant.dart';
import 'package:gallery_app/src/models/media/album_item.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:gallery_app/src/ui/media_list/cubit/media_list_cubit.dart';
import 'package:gallery_app/src/ui/preview/photo/photo_preview_page.dart';
import 'package:gallery_app/src/ui/widgets/gl_app_bar.dart';
import 'package:gallery_app/src/ui/widgets/gl_media.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaListPage extends StatefulWidget {
  const MediaListPage({Key? key}) : super(key: key);

  @override
  _MediaListPageState createState() => _MediaListPageState();
}

class _MediaListPageState extends State<MediaListPage> {
  late MediaListCubit _cubit;
  @override
  void initState() {
    _cubit = context.read<MediaListCubit>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_cubit.isInitValue) {
      List<dynamic> arguments =
          ModalRoute.of(context)?.settings.arguments as List<dynamic>;
      _cubit.initData(arguments[0]);
    }
  }

  ThumbOption thumbMediaOption(int w) {
    return ThumbOption(
      width: w,
      height: w,
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final mediaState = context.watch<MediaListCubit>().state;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            elevation: 5.0,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              // _showInputAlbumNameDialog(context).then((value) {
              //   if (value as bool && value) {
              //     _createAlbum(context);
              //   }
              // });
            }),
        appBar: GLAppBar(
          title: mediaState.album.name,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppConstant.mediaCrossAxisCount,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            final item = mediaState.album.items[index];
            return GLMedia(
              item,
              thumbMediaOption((w ~/ AppConstant.mediaCrossAxisCount)),
              () => _onTapMedia(context, item),
            );
          },
          itemCount: mediaState.album.items.length,
        ));
  }

  void _onTapMedia(BuildContext context, MediaItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhotoPreviewPage(item)),
    );
  }
}
