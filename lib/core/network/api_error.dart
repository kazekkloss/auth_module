import 'package:dio/dio.dart';

class ApiError {
  final int code;
  final String message;

  ApiError({required this.code, required this.message});

  static ApiError fromDioError(DioException error) {
    print(error.message);
    switch (error.type) {
      case DioExceptionType.cancel:
        return ApiError(code: error.response!.statusCode!, message: 'Request was cancelled');
      case DioExceptionType.connectionTimeout:
        return ApiError(code: error.response!.statusCode!, message: 'Connection timeout');
      case DioExceptionType.sendTimeout:
        return ApiError(code: error.response!.statusCode!, message: 'Send timeout');
      case DioExceptionType.receiveTimeout:
        return ApiError(code: error.response!.statusCode!, message: 'Receive timeout');
      case DioExceptionType.badResponse:
        return ApiError(code: error.response!.statusCode!, message: 'Bad response');
      case DioExceptionType.unknown:
      default:
        return ApiError(code: -1, message: 'Unexpected error');
    }
  }

  @override
  String toString() {
    return 'ApiError(code: $code, message: $message)';
  }
}
