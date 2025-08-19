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
import '../../api/data_source/resend_code/resend_code_data_source_impl.dart'
    as _i53;
import '../../api/data_source/verification/verification_data_source_impl.dart'
    as _i15;
import '../../data/data_source/resend_code/resend_code_data_source.dart'
    as _i523;
import '../../data/data_source/verification/verification_data_source.dart'
    as _i14;
import '../../data/repositories/resend_code/resend_code_repository_impl.dart'
    as _i622;
import '../../data/repositories/verification/verification_repository_impl.dart'
    as _i1003;
import '../../domain/repositories/resend_code/resend_code.dart' as _i673;
import '../../domain/repositories/verification/verification_repository.dart'
    as _i550;
import '../../domain/use_cases/resend_code/resend_code_usecase.dart' as _i335;
import '../../domain/use_cases/verification/verification_usecase.dart' as _i510;
import '../../presentation/auth/verification/views_model/verification_screen_cubit.dart'
    as _i988;
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
    gh.factory<_i523.ResendCodeDataSource>(
      () => _i53.ResendCodeDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.singleton<_i686.SharedPreferencesHelper>(
      () => _i686.SharedPreferencesHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i14.VerificationDataSource>(
      () => _i15.VreificationDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i673.ResendCodeRepository>(
      () => _i622.ResendCodeRepositoryImpl(gh<_i523.ResendCodeDataSource>()),
    );
    gh.factory<_i335.GetResendCodeUsecase>(
      () => _i335.GetResendCodeUsecase(gh<_i673.ResendCodeRepository>()),
    );
    gh.factory<_i550.VerificationRepository>(
      () =>
          _i1003.VreificationRepositoryImpl(gh<_i14.VerificationDataSource>()),
    );
    gh.factory<_i510.GetVerificationUsecase>(
      () => _i510.GetVerificationUsecase(gh<_i550.VerificationRepository>()),
    );
    gh.factory<_i988.VerificationScreenCubit>(
      () => _i988.VerificationScreenCubit(
        gh<_i335.GetResendCodeUsecase>(),
        gh<_i510.GetVerificationUsecase>(),
      ),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i912.SharedPreferencesModule {}

class _$ApiModule extends _i272.ApiModule {}
