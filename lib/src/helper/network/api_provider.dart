import 'dart:convert';

import 'package:gallery_app/src/helper/utility/http/http_exception.dart';
import 'package:gallery_app/src/models/app/app_env.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class APIProvider {
  Dio _dio;

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

  String _getToken() {
    return '';
  }

  BaseOptions _dioOptionsJson(BaseOptions dioOptions) {
    dioOptions.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${_getToken()}'
    };

    return dioOptions;
  }

  BaseOptions _dioOptionsFormData(BaseOptions dioOptions, int len) {
    dioOptions.headers = {
      'Content-Type': 'multipart/form-data',
      Headers.contentLengthHeader: len,
      'Authorization': 'Bearer ${_getToken()}'
    };
    return dioOptions;
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic> params,
      CancelToken cancelToken,
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
      {Map<String, dynamic> params,
      bool isStub = false,
      CancelToken cancelToken}) async {
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
      {Map<String, dynamic> params,
      bool isStub = false,
      CancelToken cancelToken}) async {
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

  Future<dynamic> postFromData(String path,
      {FormData formData,
      int len,
      bool isStub = false,
      CancelToken cancelToken}) async {
    _dioOptionsFormData(_dio.options, len);
    _willEnableStub(isStub);
    final response = await _dio.post(
      path,
      data: formData,
      cancelToken: cancelToken,
      onSendProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + '%');
        }
      },
    );
    throwIfNoSuccess(response);

    if (response.data is String) {
      return jsonDecode(response.data.toString());
    } else {
      return response.data;
    }
  }

  Future<dynamic> putFromData(String path,
      {FormData formData,
      int len,
      bool isStub = false,
      CancelToken cancelToken}) async {
    _dioOptionsFormData(_dio.options, len);
    _willEnableStub(isStub);
    final response = await _dio.put(
      path,
      data: formData,
      cancelToken: cancelToken,
      onSendProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + '%');
        }
      },
    );
    throwIfNoSuccess(response);

    if (response.data is String) {
      return jsonDecode(response.data.toString());
    } else {
      return response.data;
    }
  }

  void throwIfNoSuccess(Response response) {
    if (response.statusCode < 200 || response.statusCode > 299) {
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
