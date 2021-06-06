import 'package:gallery_app/src/helper/network/api_provider.dart';
import 'package:gallery_app/src/models/app/app_env.dart';

class AppRepository {
  late APIProvider _apiProvider;

  AppRepository(String baseUrl, AppEnv env) {
    _apiProvider = APIProvider(baseUrl, env);
  }

  // Future<ResponseData<List<Post>>> fetchPosts() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   return ResponseData.success(Post.dummys());
  //   //  try {
  //   //   final json = await _apiProvider.get(AppConstant.todoPath, CancelToken());
  //   //   return ResponseData.success(Post.fromJson(json));
  //   // } catch (e) {
  //   //   return ResponseData.error(e.toString());
  //   // }
  // }
}
