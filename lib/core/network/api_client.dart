import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_error.dart';

enum RequestMethod { get, post }

@lazySingleton
class ApiClient {
  final Dio _dio;
  final SharedPreferences _preferences;

  ApiClient(this._dio, this._preferences);

  Future<dynamic> request({
    required String url,
    required RequestMethod method,
    Map<String, dynamic>? data,
  }) async {
    try {
      final token = _preferences.getString('token');
      if (token != null) {
        _dio.options.headers['Authorization'] = 'Bearer $token';
      } else {
        _dio.options.headers.remove('Authorization');
      }

      Response response;

      if (method == RequestMethod.post) {
        if (data == null) {
          throw ArgumentError('Data must be provided for POST requests');
        }
        response = await _dio.post(url, data: data);
      } else if (method == RequestMethod.get) {
        response = await _dio.get(url);
      } else {
        throw ArgumentError('Unsupported HTTP method: $method');
      }
      return response.data;
    } on DioException catch (e) {
      throw ApiError.fromDioError(e);
    }
  }
}
