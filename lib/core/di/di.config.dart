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
import '../../api/data_source/forget_password/remote_data_source/forget_password_remote_data_source_impl.dart'
    as _i428;
import '../../data/data_source/forget_password/forget_password_remote_data_source.dart'
    as _i849;
import '../../data/repositories/forget_password_repo_impl/forget_password_repo_impl.dart'
    as _i1030;
import '../../domain/repositories/forget_password/forget_password_repo.dart'
    as _i72;
import '../../domain/use_cases/forget_password/forget_password_use_case.dart'
    as _i150;
import '../../presentation/auth/forget_password/views_model/forget_password_view_model.dart'
    as _i457;
import '../cache/shared_preferences_helper.dart' as _i686;
import '../cache/shared_preferences_module.dart' as _i912;
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
    gh.factory<_i849.ForgetPasswordRemoteDataSource>(
      () => _i428.ForgetPasswordRemoteDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i72.ForgetPasswordRepo>(
      () => _i1030.ForgetPasswordRepoImpl(
        gh<_i849.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i150.ForgetPasswordUseCase>(
      () => _i150.ForgetPasswordUseCase(gh<_i72.ForgetPasswordRepo>()),
    );
    gh.factory<_i457.ForgetPasswordViewModel>(
      () => _i457.ForgetPasswordViewModel(gh<_i150.ForgetPasswordUseCase>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i912.SharedPreferencesModule {}

class _$ApiModule extends _i272.ApiModule {}
