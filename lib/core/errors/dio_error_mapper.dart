import 'package:dio/dio.dart';

String mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.';

    case DioExceptionType.sendTimeout:
      return 'انتهت مهلة إرسال البيانات. يرجى المحاولة مرة أخرى.';

    case DioExceptionType.receiveTimeout:
      return 'انتهت مهلة استلام البيانات. يرجى المحاولة مرة أخرى.';

    case DioExceptionType.badResponse:
      final data = e.response?.data;
      if (data == null) return 'حدث خطأ غير متوقع.';

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

      return 'حدث خطأ غير معروف.';

    case DioExceptionType.cancel:
      return 'تم إلغاء الطلب.';

    case DioExceptionType.connectionError:
      return 'خطأ في الاتصال. يرجى التحقق من اتصالك بالإنترنت.';

    default:
      return 'حدث خطأ غير متوقع.';
  }
}
