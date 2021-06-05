import 'package:gallery_app/src/config/app_constant.dart';
import 'package:gallery_app/src/helper/network/api_provider.dart';
import 'package:gallery_app/src/helper/network/response.dart';
import 'package:gallery_app/src/models/app/app_env.dart';
import 'package:gallery_app/src/models/post/post.dart';

class PostRepository {
  APIProvider _provider;

  PostRepository(String baseUrl, AppEnv env) {
    _provider = APIProvider(baseUrl, env);
  }

  Future<ResponseData<Post>> fetch() async {
    try {
      final json = await _provider.get(AppConstant.todoPath);
      return ResponseData.success(Post.fromJson(json));
    } catch (e) {
      return ResponseData.error(e.toString());
    }
  }
}
