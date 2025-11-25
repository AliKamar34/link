import 'package:dio/dio.dart';

String mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout. Please try again.';
    case DioExceptionType.sendTimeout:
      return 'Send timeout. Please try again.';
    case DioExceptionType.receiveTimeout:
      return 'Receive timeout. Please try again.';
    case DioExceptionType.badResponse:
      final data = e.response?.data;
      if (data == null) return 'Unexpected error occurred';
      if (data is Map && data['message'] != null) {
        return data['message'];
      }
      if (data['errors'] != null && data['errors'] is Map) {
        final errorsMap = data['errors'] as Map;
        final firstErrorList = errorsMap.values.first;
        if (firstErrorList is List && firstErrorList.isNotEmpty) {
          return firstErrorList.first;
        }
      }
      return 'An unknown error occurred';
    case DioExceptionType.cancel:
      return 'Request was cancelled.';
    case DioExceptionType.connectionError:
      return 'Connection error. Check your internet connection.';
    default:
      return 'Unexpected error occurred.';
  }
}
