import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:link_task/core/errors/dio_error_mapper.dart';
import 'package:link_task/core/errors/exceptions.dart';
import 'package:link_task/core/networking/api_end_points.dart';

class DioHelper {
  late final Dio dio;
  DioHelper() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

  Future<Response> getRequest({required String endPoint}) async {
    try {
      final response = await dio.get(endPoint);
      return response;
    } on DioException catch (e, stackTrace) {
      log('GET request failed: ${e.message}', error: e, stackTrace: stackTrace);
      throw ServerException(mapDioError(e));
    }
  }

  Future<Response> postRequest({
    required String endPoint,
    required FormData data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.post(
        endPoint,
        data: data,

        options: options,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e, stackTrace) {
      log(
        'POST request failed: ${e.message}',
        error: e,
        stackTrace: stackTrace,
      );
      throw ServerException(mapDioError(e));
    }
  }
}
