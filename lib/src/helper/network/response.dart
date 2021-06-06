import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class Meta {
  int page;
  final int itemCount;
  final int total;
  final int pageCount;
  final bool hasPreviousPage;
  bool hasNextPage;

  bool get hasReachedMax {
    return !hasNextPage;
  }

  Meta(
      {this.page = 0,
      this.itemCount = 0,
      this.total = 0,
      this.pageCount = 0,
      this.hasPreviousPage = false,
      this.hasNextPage = false});
  factory Meta.fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) return Meta();
    return Meta(
        page: jsonData['page'],
        itemCount: jsonData['itemCount'],
        total: jsonData['total'],
        pageCount: jsonData['pageCount'],
        hasPreviousPage: jsonData['hasPreviousPage'],
        hasNextPage: jsonData['hasNextPage']);
  }
}

enum Status {
  SUCCESS,
  ERROR,
  INVALID_PAGE_NUMBER_ERROR,
  CANCEL,
  NO_INTERNET,
  TIMEOUT,
  CLIENT_ERROR,
  SERVER_ERROR,
  UNKNOWN
}

extension StatusExts on Status {
  String get message {
    switch (this) {
      case Status.SUCCESS:
        return 'Xữ lý Thành công!';
      case Status.ERROR:
        return 'Đã có lỗi xảy ra, vui lòng thử lại sau!';
      case Status.INVALID_PAGE_NUMBER_ERROR:
        return 'Số trang không hợp lệ!';
      case Status.CANCEL:
        return 'Huỷ xữ lý';
      case Status.NO_INTERNET:
        return 'Không có kết nối mạng, vui lòng kiểm tra mạng của bạn!';
      case Status.TIMEOUT:
        return 'Thời gian xữ lý quá lâu, vui lòng thử lại sau!';
      case Status.CLIENT_ERROR:
        return 'Đã có lỗi xảy ra, vui lòng kiểm tra thông tin của bạn và thử lại!';
      case Status.SERVER_ERROR:
        return 'Máy chủ đang gặp vấn đề nào đó, vui lòng thử lại sau!';
      case Status.UNKNOWN:
        return 'Không xác định';
    }
  }
}

class ResponseData<T> {
  late Status status;
  late T data;
  late String message = '';
  late Meta meta;

  bool isSuccess() {
    return status == Status.SUCCESS;
  }

  ResponseData.success(this.data,
      {dynamic response, Map<String, dynamic>? jsonMeta}) {
    status = Status.SUCCESS;
    if (response is Map<String, dynamic>) {
      final statusCode = response['statusCode'];
      if (statusCode != null) {
        status = _mapCodeToState(statusCode);
        message = response['message'] ?? response['error'];
      }
    }

    if (jsonMeta != null) {
      final mt = jsonMeta['data']['meta'];
      meta = Meta.fromJson(mt);
    }

    message = message.isEmpty == true ? status.message : message;
  }
  ResponseData.error(dynamic error) {
    if (error is DioError || error is DioErrorType) {
      status = _mapErrorToState(error);
      try {
        final json = jsonDecode(error?.response.toString() ?? '');
        if (json == null) {
          message = status.message;
        } else {
          message = json['message'].toString();
          message = message == 'null' ? json['error'].toString() : message;
        }
      } catch (e) {
        message = status.message;
      }
    } else {
      status = Status.ERROR;
      message = error.toString();
    }
  }

  Status _mapCodeToState(int code) {
    if (code >= 200 && code <= 299) {
      return Status.SUCCESS;
    }
    if (code >= 400 && code <= 499) {
      return Status.CLIENT_ERROR;
    }
    if (code >= 500 && code >= 599) {
      return Status.SERVER_ERROR;
    }
    return Status.UNKNOWN;
  }

  Status _mapErrorToState(dynamic error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          return Status.CANCEL;
        case DioErrorType.connectTimeout:
          return Status.TIMEOUT;
        case DioErrorType.other:
          return Status.NO_INTERNET;
        case DioErrorType.receiveTimeout:
          return Status.TIMEOUT;
        case DioErrorType.response:
          if (error.error is SocketException) {
            return Status.NO_INTERNET;
          }
          switch (error.response?.statusCode ?? -999) {
            case 400:
              return Status.INVALID_PAGE_NUMBER_ERROR;
            default:
              return Status.ERROR;
          }
        case DioErrorType.sendTimeout:
          return Status.TIMEOUT;
      }
    } else if (error is SocketException) {
      return Status.NO_INTERNET;
    }
    return Status.ERROR;
  }

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}
