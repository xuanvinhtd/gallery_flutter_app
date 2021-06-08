import 'dart:io';

import 'package:gallery_app/src/config/app_constant.dart';
import 'package:gallery_app/src/helper/network/api_provider.dart';
import 'package:gallery_app/src/helper/network/response.dart';
import 'package:gallery_app/src/models/app/app_env.dart';
import 'package:gallery_app/src/models/google/g_album.dart';
import 'package:gallery_app/src/models/google/g_media.dart';
import 'package:gallery_app/src/models/media/media_item.dart';

import 'package:path/path.dart' as path;

class AppRepository {
  late APIProvider _apiProvider;

  AppRepository(String baseUrl, AppEnv env) {
    _apiProvider = APIProvider(baseUrl, env);
  }

// ALBUM API
  Future<ResponseData<GAlbum>> createAlbum(String title) async {
    try {
      final response = await _apiProvider.post(AppConstant.albumPath, params: {
        'album': {'title': title}
      });

      final data = GAlbum.fromJson(response);

      return ResponseData.success(data, response: response);
    } catch (e) {
      return ResponseData.error(e);
    }
  }

  Future<ResponseData<GAlbum>> getAlbum(String id) async {
    try {
      final response = await _apiProvider.get(
        AppConstant.albumPath + '/$id',
      );
      return ResponseData.success(GAlbum.fromJson(response),
          response: response);
    } catch (e) {
      return ResponseData.error(e);
    }
  }

  Future<ResponseData<List<GAlbum>>> listAlbums(
      {int pageSize = 50, bool excludeNonAppCreatedData = true}) async {
    try {
      final response = await _apiProvider.get(AppConstant.albumPath, params: {
        'pageSize': pageSize,
        'excludeNonAppCreatedData': excludeNonAppCreatedData
      });
      List<dynamic> dataArr = response['albums'];

      var data = <GAlbum>[];
      dataArr.forEach((element) {
        data.add(GAlbum.fromJson(element));
      });

      return ResponseData.success(data, response: response);
    } catch (e) {
      return ResponseData.error(e);
    }
  }

  Future<ResponseData<List<MediaItem>>> fetchMeidItemOfAlbums(String albumId,
      {int pageSize = 50,
      bool excludeNonAppCreatedData = true,
      String pageToken = ''}) async {
    try {
      final response = await _apiProvider.post(AppConstant.searhMediaItems,
          params: {'albumId': albumId, 'pageSize': pageSize});
      List<dynamic> dataArr = response['mediaItems'];

      var data = <GMediaItem>[];

      dataArr.forEach((element) {
        data.add(GMediaItem.fromJson(element));
      });
      final mediaList = data.map((e) => e.mapToMediaItem()).toList();

      return ResponseData.success(mediaList, response: response);
    } catch (e) {
      return ResponseData.error(e);
    }
  }

  Future<ResponseData> uploadMediaItem(File image, String albumId) async {
    // Get the filename of the image
    final fileName = path.basename(image.path);
    final fileType = path.extension(image.path).replaceAll('.', '');
    try {
      final uploadToken = await _apiProvider.uploadData(
        AppConstant.uploadImagePath,
        fileName,
        fileType,
        image,
      );
      print("Print Token:$uploadToken");
      final createPatch =
          await batchCreateMediaItems(albumId, uploadToken, fileName);
      return createPatch;
    } catch (e) {
      print("Print Token ERROR:$e");
      return ResponseData.error(e);
    }
  }

  Future<ResponseData> batchCreateMediaItems(
      String albumId, String uploadToken, String fileName) async {
    try {
      final response =
          await _apiProvider.post(AppConstant.createMediaItemPath, params: {
        'albumId': albumId,
        "newMediaItems": [
          {
            'description': fileName,
            'simpleMediaItem': {
              'uploadToken': uploadToken,
              'fileName': fileName
            }
          }
        ]
      });
      return ResponseData.success([], response: response);
    } catch (e) {
      return ResponseData.error(e);
    }
  }

// MEDIA API
  Future<ResponseData<List<MediaItem>>> fetchMediaItems(
      {int pageSize = 50, String pageToken = ''}) async {
    try {
      final response =
          await _apiProvider.get(AppConstant.mediaItemPath, params: {
        'pageSize': pageSize,
      });
      List<dynamic> dataArr = response['mediaItems'];

      var data = <GMediaItem>[];
      dataArr.forEach((element) {
        data.add(GMediaItem.fromJson(element));
      });
      final mediaList = data.map((e) => e.mapToMediaItem()).toList();
      return ResponseData.success(mediaList, response: response);
    } catch (e) {
      return ResponseData.error(e);
    }
  }
}
