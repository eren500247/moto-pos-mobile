


import 'package:dio/dio.dart';
import 'package:pos_test/common/constant/api_url.dart';
import 'package:pos_test/core/network/logger_interceptor.dart';

class DioClient {
  late final Dio _dio;
  static const _duration = Duration(seconds: 10);

  DioClient() : _dio = Dio(
    BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      connectTimeout: _duration,
      receiveTimeout: _duration,
      responseType: ResponseType.json,
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  ){
    _dio.interceptors.add(LoggerInterceptor());
  }


  Future<Response<T>> get<T>(
    String path,
    {
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
    }
  ) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException {
      rethrow;
    }
  }

  Future<Response<T>> post<T>(
    String path,
    {
      dynamic data,
      Map<String, dynamic>? queryParameters,  
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
    }
  ) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException {
      rethrow;
    }
  }

  Future<Response<T>> put<T>(
    String path,
    {
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
    }
  ) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException {
      rethrow;
    }
  }

  Future<Response<T>> delete<T>(
    String path,
    {
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
    }
  ) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException {
      rethrow;
    }
  }

}


