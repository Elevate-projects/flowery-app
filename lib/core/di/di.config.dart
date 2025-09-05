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
import '../../api/data_source/categories/remote_data_source/categories_remote_data_source_impl.dart'
    as _i699;
import '../../api/data_source/forget_password/remote_data_source/forget_password_remote_data_source_impl.dart'
    as _i428;
import '../../api/data_source/home_products/home_products_data_source_impl.dart'
    as _i81;
import '../../api/data_source/login/remote_data_source/login_remote_data_source_impl.dart'
    as _i221;
import '../../api/data_source/profile/remote_data_source/profile_remote_data_source_impl.dart'
    as _i913;
import '../../api/data_source/register/remote_data_source/register_remote_data_source_impl.dart'
    as _i281;
import '../../data/data_source/categories/remote_data_source/categories_remote_data_source.dart'
    as _i960;
import '../../data/data_source/forget_password/forget_password_remote_data_source.dart'
    as _i849;
import '../../data/data_source/home_products/home_products_data_source.dart'
    as _i950;
import '../../data/data_source/login/remote_data_source/login_remote_data_source.dart'
    as _i684;
import '../../data/data_source/profile/remote_data_source/profile_remote_data_source.dart'
    as _i470;
import '../../data/data_source/register/remote_data_source/register_remote_data_source.dart'
    as _i233;
import '../../data/repositories/categories/categories_repository_impl.dart'
    as _i940;
import '../../data/repositories/forget_password_repo_impl/forget_password_repo_impl.dart'
    as _i1030;
import '../../data/repositories/home_products/home_products_repository_impl_.dart'
    as _i713;
import '../../data/repositories/login/login_repository_impl.dart' as _i722;
import '../../data/repositories/profile/profile_repository_impl.dart' as _i770;
import '../../data/repositories/register/register_repository_impl.dart' as _i40;
import '../../domain/repositories/categories/categories_repository.dart'
    as _i660;
import '../../domain/repositories/forget_password/forget_password_repo.dart'
    as _i72;
import '../../domain/repositories/home_products/home_products_repository.dart'
    as _i168;
import '../../domain/repositories/login/login_repository.dart' as _i300;
import '../../domain/repositories/profile/profile_repository.dart' as _i445;
import '../../domain/repositories/register/register_repository.dart' as _i638;
import '../../domain/use_cases/categories/get_all_categories_use_case.dart'
    as _i824;
import '../../domain/use_cases/categories/get_all_products_use_case.dart'
    as _i969;
import '../../domain/use_cases/forget_password/forget_password_use_case.dart'
    as _i150;
import '../../domain/use_cases/home_products/home_products_use_case.dart'
    as _i627;
import '../../domain/use_cases/login/login_with_email_and_password_use_case.dart'
    as _i197;
import '../../domain/use_cases/profile/get_user_profile_data_use_case.dart'
    as _i306;
import '../../domain/use_cases/register/register_use_case.dart' as _i950;
import '../../presentation/about_us/views_model/about_us_cubit.dart' as _i225;
import '../../presentation/auth/forget_password/views_model/forget_password_view_model.dart'
    as _i457;
import '../../presentation/auth/login/views_model/login_cubit.dart' as _i512;
import '../../presentation/auth/register/view_model/register_cubit.dart'
    as _i536;
import '../../presentation/categories/views_model/categories_cubit.dart'
    as _i200;
import '../../presentation/home/home_screen/view_model/home_products_cubit.dart'
    as _i641;
import '../../presentation/product_details/views_model/product_details_cubit.dart'
    as _i586;
import '../../presentation/profile/views_model/profile_cubit.dart' as _i1028;
import '../../presentation/terms_and_conditions/views_model/terms_and_conditions_cubit.dart'
    as _i297;
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
    gh.factory<_i225.AboutUsCubit>(() => _i225.AboutUsCubit());
    gh.factory<_i586.ProductDetailsCubit>(() => _i586.ProductDetailsCubit());
    gh.factory<_i297.TermsAndConditionsCubit>(
      () => _i297.TermsAndConditionsCubit(),
    );
    gh.singleton<_i361.Dio>(() => apiModule.provideDio());
    gh.singleton<_i23.SecureStorage>(() => _i23.SecureStorage());
    gh.factory<_i508.ApiClient>(() => _i508.ApiClient(gh<_i361.Dio>()));
    gh.singleton<_i686.SharedPreferencesHelper>(
      () => _i686.SharedPreferencesHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i233.RegisterRemoteDataSource>(
      () => _i281.RegisterRemoteDataSourceImpl(
        gh<_i508.ApiClient>(),
        gh<_i23.SecureStorage>(),
      ),
    );
    gh.factory<_i684.LoginRemoteDataSource>(
      () => _i221.LoginRemoteDataSourceImpl(
        gh<_i508.ApiClient>(),
        gh<_i23.SecureStorage>(),
      ),
    );
    gh.factory<_i209.GlobalCubit>(
      () => _i209.GlobalCubit(
        gh<_i23.SecureStorage>(),
        gh<_i686.SharedPreferencesHelper>(),
      ),
    );
    gh.factory<_i950.HomeProductsDataSource>(
      () => _i81.HomeProductsDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i849.ForgetPasswordRemoteDataSource>(
      () => _i428.ForgetPasswordRemoteDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i470.ProfileRemoteDataSource>(
      () => _i913.ProfileRemoteDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i960.CategoriesRemoteDataSource>(
      () => _i699.CategoriesRemoteDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i638.RegisterRepository>(
      () => _i40.RegisterRepositoryImpl(gh<_i233.RegisterRemoteDataSource>()),
    );
    gh.factory<_i445.ProfileRepository>(
      () => _i770.ProfileRepositoryImpl(gh<_i470.ProfileRemoteDataSource>()),
    );
    gh.factory<_i168.HomeProductsRepository>(
      () =>
          _i713.HomeProductsRepositoryImpl(gh<_i950.HomeProductsDataSource>()),
    );
    gh.factory<_i306.GetUserProfileDataUseCase>(
      () => _i306.GetUserProfileDataUseCase(gh<_i445.ProfileRepository>()),
    );
    gh.factory<_i72.ForgetPasswordRepo>(
      () => _i1030.ForgetPasswordRepoImpl(
        gh<_i849.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i300.LoginRepository>(
      () => _i722.LoginRepositoryImpl(
        loginRemoteDataSource: gh<_i684.LoginRemoteDataSource>(),
      ),
    );
    gh.factory<_i627.HomeProductsUseCase>(
      () => _i627.HomeProductsUseCase(gh<_i168.HomeProductsRepository>()),
    );
    gh.factory<_i197.LoginWithEmailAndPasswordUseCase>(
      () => _i197.LoginWithEmailAndPasswordUseCase(gh<_i300.LoginRepository>()),
    );
    gh.factory<_i1028.ProfileCubit>(
      () => _i1028.ProfileCubit(gh<_i306.GetUserProfileDataUseCase>()),
    );
    gh.factory<_i660.CategoriesRepository>(
      () => _i940.CategoriesRepositoryImpl(
        gh<_i960.CategoriesRemoteDataSource>(),
      ),
    );
    gh.factory<_i824.GetAllCategoriesUseCase>(
      () => _i824.GetAllCategoriesUseCase(gh<_i660.CategoriesRepository>()),
    );
    gh.factory<_i969.GetAllProductsUseCase>(
      () => _i969.GetAllProductsUseCase(gh<_i660.CategoriesRepository>()),
    );
    gh.factory<_i641.HomeProductsCubit>(
      () => _i641.HomeProductsCubit(gh<_i627.HomeProductsUseCase>()),
    );
    gh.factory<_i950.RegisterUseCase>(
      () => _i950.RegisterUseCase(gh<_i638.RegisterRepository>()),
    );
    gh.factory<_i150.ForgetPasswordUseCase>(
      () => _i150.ForgetPasswordUseCase(gh<_i72.ForgetPasswordRepo>()),
    );
    gh.factory<_i512.LoginCubit>(
      () => _i512.LoginCubit(
        gh<_i197.LoginWithEmailAndPasswordUseCase>(),
        gh<_i23.SecureStorage>(),
        gh<_i686.SharedPreferencesHelper>(),
      ),
    );
    gh.factory<_i200.CategoriesCubit>(
      () => _i200.CategoriesCubit(
        gh<_i824.GetAllCategoriesUseCase>(),
        gh<_i969.GetAllProductsUseCase>(),
      ),
    );
    gh.factory<_i536.RegisterCubit>(
      () => _i536.RegisterCubit(gh<_i950.RegisterUseCase>()),
    );
    gh.factory<_i457.ForgetPasswordViewModel>(
      () => _i457.ForgetPasswordViewModel(gh<_i150.ForgetPasswordUseCase>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i912.SharedPreferencesModule {}

class _$ApiModule extends _i272.ApiModule {}
