import 'package:injectable/injectable.dart';
import 'package:milestory_web/core/constants/api_constants.dart';
import 'package:milestory_web/core/exception/exceptions.dart';
import 'package:milestory_web/core/network/api_error.dart';
import 'package:milestory_web/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/api_client.dart';

abstract class AuthDataSource {
  Future<DataState<UserModel>> signUp({required String email, required String password});
  Future<DataState<UserModel>> signIn({required String email, required String password});
  Future<DataState<UserModel>> checkAuth();
  Future<DataState> logout();
}

@LazySingleton(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final ApiClient apiClient;

  AuthDataSourceImpl(this.apiClient);

  @override
  Future<DataState<UserModel>> signUp({required String email, required String password}) async {
    try {
      final response = await apiClient.request(
        url: ApiConstants.signUp,
        method: RequestMethod.post,
        data: {'email': email, 'password': password},
      );
      final userModel = UserModel.fromJson(response);
      return DataSuccess(userModel);
    } catch (e) {
      return DataFailed(e as ApiError);
    }
  }

  @override
  Future<DataState<UserModel>> signIn({required String email, required String password}) async {
    try {
      final response = await apiClient.request(
        url: ApiConstants.signIn,
        method: RequestMethod.post,
        data: {'email': email, 'password': password},
      );
      final token = response['token'];
      final userModel = UserModel.fromJson(response['user']);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return DataSuccess(userModel);
    } catch (e) {
      return DataFailed(e as ApiError);
    }
  }

  @override
  Future<DataState<UserModel>> checkAuth() async {
    try {
      final response = await apiClient.request(url: ApiConstants.checkAuth, method: RequestMethod.get);
      final userModel = UserModel.fromJson(response);
      return DataSuccess(userModel);
    } catch (e) {
      return DataFailed(e as ApiError);
    }
  }

  @override
  Future<DataState> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      return const DataSuccess();
    } catch (e) {
      return DataFailed(ApiError(code: 500, message: 'Failed to log out'));
    }
  }
}
