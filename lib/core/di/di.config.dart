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
import '../../api/data_source/home_products/home_products_data_source_impl.dart'
    as _i102;
import '../../data/data_source/home_products/home_products_data_source.dart'
    as _i950;
import '../../data/repositories/home_products/home_products_repository_impl_.dart'
    as _i713;
import '../../domain/repositories/home_products/home_products_repository.dart'
    as _i168;
import '../../domain/use_cases/home_products/home_products_use_case.dart'
    as _i627;
import '../../presentation/home/home_screen/view_model/home_products_cubit.dart'
    as _i641;
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
    gh.factory<_i950.HomeProductsDataSource>(
      () => _i102.HomeProductsDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.singleton<_i686.SharedPreferencesHelper>(
      () => _i686.SharedPreferencesHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i168.HomeProductsRepository>(
      () =>
          _i713.HomeProductsRepositoryImpl(gh<_i950.HomeProductsDataSource>()),
    );
    gh.factory<_i627.HomeProductsUseCase>(
      () => _i627.HomeProductsUseCase(gh<_i168.HomeProductsRepository>()),
    );
    gh.factory<_i641.HomeProductsCubit>(
      () => _i641.HomeProductsCubit(gh<_i627.HomeProductsUseCase>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i912.SharedPreferencesModule {}

class _$ApiModule extends _i272.ApiModule {}
