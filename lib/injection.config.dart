// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:milestory_web/core/network/api_client.dart' as _i4;
import 'package:milestory_web/features/auth/data/datasources/auth_data_source.dart'
    as _i7;
import 'package:milestory_web/features/auth/data/repositories/auth_repository_impl.dart'
    as _i9;
import 'package:milestory_web/features/auth/domain/repository/auth_repository.dart'
    as _i8;
import 'package:milestory_web/features/auth/presentation/auth_bloc/auth_bloc.dart'
    as _i10;
import 'package:milestory_web/features/creator/presentaton/map_bloc/map_bloc.dart'
    as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.MapBloc>(() => _i3.MapBloc());
    gh.lazySingleton<_i4.ApiClient>(() => _i4.ApiClient(
          gh<_i5.Dio>(),
          gh<_i6.SharedPreferences>(),
        ));
    gh.lazySingleton<_i7.AuthDataSource>(
        () => _i7.AuthDataSourceImpl(gh<_i4.ApiClient>()));
    gh.lazySingleton<_i8.AuthRepository>(
        () => _i9.AuthRepositoryImpl(authDataSource: gh<_i7.AuthDataSource>()));
    gh.factory<_i10.AuthBloc>(
        () => _i10.AuthBloc(authRepository: gh<_i8.AuthRepository>()));
    return this;
  }
}
