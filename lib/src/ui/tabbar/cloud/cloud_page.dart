import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/src/config/app_routes.dart';
import 'package:gallery_app/src/helper/localization/app_bloc_localization.dart';
import 'package:gallery_app/src/models/media/album_item.dart';
import 'package:gallery_app/src/models/media/media_item.dart';
import 'package:gallery_app/src/models/view_mode.dart';
import 'package:gallery_app/src/ui/media_list/media_list_page.dart';
import 'package:gallery_app/src/ui/preview/photo/photo_preview_page.dart';
import 'package:gallery_app/src/ui/preview/video/video_preview_page.dart';
import 'package:gallery_app/src/ui/tabbar/cloud/cubit/cloud_cubit.dart';
import 'package:gallery_app/src/ui/tabbar/cloud/cubit/cloud_state.dart';
import 'package:gallery_app/src/ui/widgets/gl_album.dart';
import 'package:gallery_app/src/ui/widgets/gl_app_bar.dart';
import 'package:gallery_app/src/ui/widgets/gl_button.dart';
import 'package:gallery_app/src/ui/widgets/gl_error_dialog.dart';
import 'package:gallery_app/src/ui/widgets/gl_media.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:photo_manager/photo_manager.dart';

class CloudPage extends StatelessWidget {
  const CloudPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            elevation: 5.0,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              _showInputAlbumNameDialog(context).then((value) {
                if (value as bool && value) {
                  _createAlbum(context);
                }
              });
            }),
        appBar: GLAppBar(
          title: AppLocalization.of(context).cloud,
        ),
        body: BlocBuilder<CloudCubit, CloudState>(builder: (context, state) {
          if (state.isLoggedIn) {
            return _ListMedia();
          }
          return const _LoginView();
        }));
  }

  Future<void> _showInputAlbumNameDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          content: Container(
            height: 180,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Text(
                  'Đặt tên cho album của bạn',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.bodyText2,
                    hintText: 'Nhập tên',
                    counterText: '',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Color(0xFFB8B8B8)),
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          width: 1, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onChanged: (value) {
                    context.read<CloudCubit>().albumTitle = value;
                  },
                  maxLength: 200,
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 8),
                      child: GLButton(
                        'Huỷ',
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        size: Size(110, 35),
                        borderRadius: 20,
                        backgroundColor: Theme.of(context).primaryColor,
                        borderColor: Theme.of(context).primaryColor,
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 8),
                      child: GLButton(
                        'Tạo',
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        size: Size(110, 35),
                        borderRadius: 20,
                        backgroundColor: Theme.of(context).primaryColor,
                        borderColor: Theme.of(context).primaryColor,
                        style: Theme.of(context).textTheme.button?.copyWith(
                            color: Theme.of(context).backgroundColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _createAlbum(BuildContext context) {
    final cubit = context.read<CloudCubit>();
    cubit.createAlnum((msg, album) {
      if (msg == null) {
        Navigator.of(context)
            .pushNamed(AppRoutes.media_list_page, arguments: [album!]);
      } else {
        showErrorDialog(context, msg);
      }
    });
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Login to use Google Photos',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15),
            ),
            onPressed: () async {
              try {
                final cubit = context.read<CloudCubit>();
                cubit.signGoogle((msg) => showErrorDialog(context, msg));
              } on Exception catch (error) {
                showErrorDialog(context, error.toString());
              }
            },
            child: const Text('Connect with Google Photos'),
          ),
        ],
      ),
    );
  }
}

class _ListMedia extends StatelessWidget {
  const _ListMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final galleyState = context.watch<CloudCubit>().state;
    final data = dataSource(galleyState);
    return LoadingOverlay(
      isLoading: galleyState.isLoading,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        gridDelegate: _currentSliverGridDelegate(galleyState.mode),
        itemBuilder: (context, index) {
          return _builItem(data, index, context);
        },
        itemCount: data.length,
      ),
    );
  }

  List<dynamic> dataSource(CloudState state) {
    if (state.mode.isAlbum) {
      return state.albums;
    }
    return state.medias;
  }

  Widget _builItem(List<dynamic> data, int index, BuildContext context) {
    final item = data[index];
    if (item is AlbumItem) {
      return GLAlbum(item, null, () => _onTapAlbum(context, item));
    } else if (item is MediaItem) {
      return GLMedia(item, null, () {
        _onTapMedia(context, item);
      });
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

  void _onTapMedia(BuildContext context, MediaItem item) async {
    String mediaUrl = '';
    if (item.entity?.type == AssetType.video) {
      mediaUrl = await item.entity?.getMediaUrl() ?? '';
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => item.entity?.type == AssetType.image
              ? PhotoPreviewPage(item)
              : VideoPreview(item, mediaUrl)),
    );
  }

  void _onTapAlbum(BuildContext context, AlbumItem item) {
    Navigator.of(context)
        .pushNamed(AppRoutes.media_list_page, arguments: [item]);
  }
}
