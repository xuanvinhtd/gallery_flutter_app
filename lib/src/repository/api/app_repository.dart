import 'dart:io';

import 'package:gallery_app/src/config/app_constant.dart';
import 'package:gallery_app/src/helper/network/api_provider.dart';
import 'package:gallery_app/src/helper/network/response.dart';
import 'package:gallery_app/src/models/app/app_env.dart';
import 'package:gallery_app/src/models/google/g_album.dart';

import 'package:path/path.dart' as path;

class AppRepository {
  late APIProvider _apiProvider;

  AppRepository(String baseUrl, AppEnv env) {
    _apiProvider = APIProvider(baseUrl, env);
  }

  Future<ResponseData<GAlbum>> createAlbum(String title) async {
    try {
      final response = await _apiProvider.post(AppConstant.albumPath, params: {
        'album': {'title': title}
      });

      final data = GAlbum.fromJson(response);
      print("OKI--> ${data.id}");
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

  Future<ResponseData> uploadMediaItem(File image) async {
    // Get the filename of the image
    final filename = path.basename(image.path);
    try {
      final response = await _apiProvider.uploadData(
        AppConstant.uploadImagePath,
        filename,
        image,
      );
      return ResponseData.success(GAlbum.fromJson(response),
          response: response);
    } catch (e) {
      return ResponseData.error(e);
    }
  }
}
