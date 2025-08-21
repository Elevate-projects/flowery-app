// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../api/client/api_client.dart' as _i508;
import '../../api/client/api_module.dart' as _i272;
import '../../api/data_source/splash/remote_data_source/splash_remote_data_source_impl.dart'
    as _i1009;
import '../../data/data_source/splash/remote_data_source/splash_remote_data_source.dart'
    as _i592;
import '../../data/repositories/splash/splash_repository_impl.dart' as _i928;
import '../../domain/repositories/splash/splash_repository.dart' as _i967;
import '../../domain/use_cases/splash/get_user_data_use_case.dart' as _i947;
import '../../presentation/splash/views_model/splash_cubit.dart' as _i684;
import '../cache/shared_preferences_helper.dart' as _i686;
import '../cache/shared_preferences_module.dart' as _i912;
import '../global_cubit/global_cubit.dart' as _i209;
import '../secure_storage/secure_storage.dart' as _i23;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final apiModule = _$ApiModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => apiModule.provideDio());
    gh.singleton<_i23.SecureStorage>(() => _i23.SecureStorage());
    gh.factory<_i508.ApiClient>(() => _i508.ApiClient(gh<_i361.Dio>()));
    gh.singleton<_i686.SharedPreferencesHelper>(
      () => _i686.SharedPreferencesHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i209.GlobalCubit>(
      () => _i209.GlobalCubit(gh<_i23.SecureStorage>()),
    );
    gh.factory<_i592.SplashRemoteDataSource>(
      () => _i1009.SplashRemoteDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i967.SplashRepository>(
      () => _i928.SplashRepositoryImpl(gh<_i592.SplashRemoteDataSource>()),
    );
    gh.factory<_i947.GetUserDataUseCase>(
      () => _i947.GetUserDataUseCase(gh<_i967.SplashRepository>()),
    );
    gh.factory<_i684.SplashCubit>(
      () => _i684.SplashCubit(
        gh<_i947.GetUserDataUseCase>(),
        gh<_i23.SecureStorage>(),
      ),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i912.SharedPreferencesModule {}

class _$ApiModule extends _i272.ApiModule {}
