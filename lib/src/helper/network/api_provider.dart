import 'dart:convert';
import 'dart:io';

import 'package:gallery_app/src/helper/utility/http/http_exception.dart';
import 'package:gallery_app/src/models/app/app_env.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:gallery_app/src/ui/app/app_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:http/http.dart' as http;

class APIProvider {
  late Dio _dio;

  APIProvider(String baseUrl, AppEnv env) {
    var dioOptions = BaseOptions();
    dioOptions.connectTimeout = 30000; //30s
    dioOptions.receiveTimeout = 30000;
    dioOptions.receiveTimeout = 30000;
    dioOptions.baseUrl = baseUrl;
    dioOptions.responseType = ResponseType.json;

    dioOptions = _dioOptionsJson(dioOptions);

    _dio = Dio(dioOptions);
    if (env == AppEnv.dev) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
    }
  }

  Map<String, String> _googleAuthHeaders() {
    return AppManager().authHeaders ?? {};
  }

  BaseOptions _dioOptionsJson(BaseOptions dioOptions) {
    print("HEADER->${_googleAuthHeaders()}");
    dioOptions.headers = _googleAuthHeaders();
    return dioOptions;
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic>? params,
      CancelToken? cancelToken,
      bool isStub = false}) async {
    _dioOptionsJson(_dio.options);
    _willEnableStub(isStub);
    final response =
        await _dio.get(path, queryParameters: params, cancelToken: cancelToken);
    throwIfNoSuccess(response);
    if (response.data is String) {
      return jsonDecode(response.data.toString());
    } else {
      return response.data;
    }
  }

  Future<dynamic> post(String path,
      {Map<String, dynamic>? params,
      bool isStub = false,
      CancelToken? cancelToken}) async {
    _dioOptionsJson(_dio.options);
    _willEnableStub(isStub);
    final response =
        await _dio.post(path, data: params, cancelToken: cancelToken);
    throwIfNoSuccess(response);

    if (response.data is String) {
      return jsonDecode(response.data.toString());
    } else {
      return response.data;
    }
  }

  Future<dynamic> put(String path,
      {Map<String, dynamic>? params,
      bool isStub = false,
      CancelToken? cancelToken}) async {
    _dioOptionsJson(_dio.options);
    _willEnableStub(isStub);
    final response =
        await _dio.put(path, data: params, cancelToken: cancelToken);
    throwIfNoSuccess(response);

    if (response.data is String) {
      return jsonDecode(response.data.toString());
    } else {
      return response.data;
    }
  }

  Future<dynamic> uploadData(
    String path,
    String fileName,
    String fileExtension,
    File image,
  ) async {
    final response = await http.post(
      Uri.parse(_dio.options.baseUrl + path),
      body: image.readAsBytesSync(),
      headers: _googleAuthHeaders(),
    );
    return response.body;
  }

  void throwIfNoSuccess(Response response) {
    if (response.statusCode == null) return;
    if (response.statusCode! < 200 || response.statusCode! > 299) {
      throw HttpException(response);
    }
  }

  void _willEnableStub(bool isEnable) {
    if (isEnable) {
      // _dio.httpClientAdapter = StubDio();
    } else {
      _dio.httpClientAdapter = DefaultHttpClientAdapter();
      // final charlesHost = AppManager().charlesHost;
      // if (charlesHost?.isNotEmpty == true) {
      //   (_dio.httpClientAdapter as DefaultHttpClientAdapter)
      //       .onHttpClientCreate = (client) {
      //     client.findProxy = (uri) => 'PROXY $charlesHost:8888;';
      //     client.badCertificateCallback =
      //         (X509Certificate cert, String host, int port) => true;
      //   };
      // }
    }
  }
}
