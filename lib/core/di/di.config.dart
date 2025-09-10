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
import '../../api/data_source/cart/remote_data_source_delete_item_imp/remote_data_source_delete_item_imp.dart'
    as _i618;
import '../../api/data_source/cart/remote_data_source_get_logged_user_imp/remote_data_source_get_logged_user_imp.dart'
    as _i874;
import '../../api/data_source/cart/remote_data_source_quantity_request_imp/remote_data_source_quantity_request_imp.dart'
    as _i693;
import '../../api/data_source/categories/remote_data_source/categories_remote_data_source_impl.dart'
    as _i699;
import '../../api/data_source/forget_password/remote_data_source/forget_password_remote_data_source_impl.dart'
    as _i428;
import '../../api/data_source/login/remote_data_source/login_remote_data_source_impl.dart'
    as _i221;
import '../../api/data_source/register/remote_data_source/register_remote_data_source_impl.dart'
    as _i281;
import '../../data/data_source/cart/remote_data_source_delete_item/remote_data_source_delete_item.dart'
    as _i631;
import '../../data/data_source/cart/remote_data_source_get_logged_user/remote_data_source_get_logged_user.dart'
    as _i691;
import '../../data/data_source/cart/remote_data_source_quantity_request/remote_data_source_quantity_request.dart'
    as _i879;
import '../../data/data_source/categories/remote_data_source/categories_remote_data_source.dart'
    as _i960;
import '../../data/data_source/forget_password/forget_password_remote_data_source.dart'
    as _i849;
import '../../data/data_source/login/remote_data_source/login_remote_data_source.dart'
    as _i684;
import '../../data/data_source/register/remote_data_source/register_remote_data_source.dart'
    as _i233;
import '../../data/repositories/cart/cart_repo_imp/cart_repositories_impl.dart'
    as _i112;
import '../../data/repositories/cart/delete_item_repo_imp/delete_item_repositories_imp.dart'
    as _i6;
import '../../data/repositories/cart/remove_quantity_repo_imp/remove_quantity_repositories_imp.dart'
    as _i954;
import '../../data/repositories/categories/categories_repository_impl.dart'
    as _i940;
import '../../data/repositories/forget_password_repo_impl/forget_password_repo_impl.dart'
    as _i1030;
import '../../data/repositories/login/login_repository_impl.dart' as _i722;
import '../../data/repositories/register/register_repository_impl.dart' as _i40;
import '../../domain/repositories/cart/cart_repositories/cart_repositories.dart'
    as _i757;
import '../../domain/repositories/cart/delete_item_repositories/delete_item_repositories.dart'
    as _i330;
import '../../domain/repositories/cart/quantity_repositories/quantity_repositories.dart'
    as _i378;
import '../../domain/repositories/categories/categories_repository.dart'
    as _i660;
import '../../domain/repositories/forget_password/forget_password_repo.dart'
    as _i72;
import '../../domain/repositories/login/login_repository.dart' as _i300;
import '../../domain/repositories/register/register_repository.dart' as _i638;
import '../../domain/use_cases/cart/cart_use_case/cart_use_case.dart' as _i257;
import '../../domain/use_cases/cart/delete_cart_item_use_case/delete_cart_item_use_case.dart'
    as _i195;
import '../../domain/use_cases/cart/quantity_use_case/quantity_use_case.dart'
    as _i618;
import '../../domain/use_cases/categories/get_all_categories_use_case.dart'
    as _i824;
import '../../domain/use_cases/categories/get_all_products_use_case.dart'
    as _i969;
import '../../domain/use_cases/forget_password/forget_password_use_case.dart'
    as _i150;
import '../../domain/use_cases/login/login_with_email_and_password_use_case.dart'
    as _i197;
import '../../domain/use_cases/register/register_use_case.dart' as _i950;
import '../../presentation/auth/forget_password/views_model/forget_password_view_model.dart'
    as _i457;
import '../../presentation/auth/login/views_model/login_cubit.dart' as _i512;
import '../../presentation/auth/register/view_model/register_cubit.dart'
    as _i536;
import '../../presentation/cart/view_model/cart_cubit.dart' as _i764;
import '../../presentation/cart/view_model/delete_cubit/delete_cubit.dart'
    as _i28;
import '../../presentation/cart/view_model/quantity_cubit/quantity_cubit.dart'
    as _i46;
import '../../presentation/categories/views_model/categories_cubit.dart'
    as _i200;
import '../../presentation/product_details/views_model/product_details_cubit.dart'
    as _i586;
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
    gh.factory<_i586.ProductDetailsCubit>(() => _i586.ProductDetailsCubit());
    gh.singleton<_i361.Dio>(() => apiModule.provideDio());
    gh.singleton<_i23.SecureStorage>(() => _i23.SecureStorage());
    gh.factory<_i508.ApiClient>(() => _i508.ApiClient(gh<_i361.Dio>()));
    gh.singleton<_i686.SharedPreferencesHelper>(
      () => _i686.SharedPreferencesHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i879.RemoteDataSourceQuantityRequest>(
      () => _i693.RemoteDataSourceQuantityRequestImp(gh<_i508.ApiClient>()),
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
    gh.factory<_i849.ForgetPasswordRemoteDataSource>(
      () => _i428.ForgetPasswordRemoteDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i631.RemoteDataSourceDeleteItem>(
      () =>
          _i618.RemoteDataSourceDeleteItemImp(apiClient: gh<_i508.ApiClient>()),
    );
    gh.factory<_i691.RemoteDataSourceGetLoggedUser>(
      () => _i874.RemoteDataSourceGetLoggedUserImp(gh<_i508.ApiClient>()),
    );
    gh.factory<_i960.CategoriesRemoteDataSource>(
      () => _i699.CategoriesRemoteDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i638.RegisterRepository>(
      () => _i40.RegisterRepositoryImpl(gh<_i233.RegisterRemoteDataSource>()),
    );
    gh.factory<_i378.RemoveQuantityRepositories>(
      () => _i954.QuantityRepositoriesImp(
        gh<_i879.RemoteDataSourceQuantityRequest>(),
      ),
    );
    gh.factory<_i757.CartRepository>(
      () => _i112.CartRepositoryImpl(gh<_i691.RemoteDataSourceGetLoggedUser>()),
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
    gh.factory<_i197.LoginWithEmailAndPasswordUseCase>(
      () => _i197.LoginWithEmailAndPasswordUseCase(gh<_i300.LoginRepository>()),
    );
    gh.factory<_i618.QuantityUseCase>(
      () => _i618.QuantityUseCase(gh<_i378.RemoveQuantityRepositories>()),
    );
    gh.factory<_i660.CategoriesRepository>(
      () => _i940.CategoriesRepositoryImpl(
        gh<_i960.CategoriesRemoteDataSource>(),
      ),
    );
    gh.factory<_i257.GetLoggedUserCartUseCase>(
      () => _i257.GetLoggedUserCartUseCase(gh<_i757.CartRepository>()),
    );
    gh.factory<_i46.QuantityCubit>(
      () => _i46.QuantityCubit(gh<_i618.QuantityUseCase>()),
    );
    gh.factory<_i330.DeleteItemRepositories>(
      () =>
          _i6.DeleteItemRepositoriesImp(gh<_i631.RemoteDataSourceDeleteItem>()),
    );
    gh.factory<_i764.CartCubit>(
      () => _i764.CartCubit(gh<_i257.GetLoggedUserCartUseCase>()),
    );
    gh.factory<_i824.GetAllCategoriesUseCase>(
      () => _i824.GetAllCategoriesUseCase(gh<_i660.CategoriesRepository>()),
    );
    gh.factory<_i969.GetAllProductsUseCase>(
      () => _i969.GetAllProductsUseCase(gh<_i660.CategoriesRepository>()),
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
    gh.factory<_i195.DeleteCartItemUseCase>(
      () => _i195.DeleteCartItemUseCase(gh<_i330.DeleteItemRepositories>()),
    );
    gh.factory<_i536.RegisterCubit>(
      () => _i536.RegisterCubit(gh<_i950.RegisterUseCase>()),
    );
    gh.factory<_i457.ForgetPasswordViewModel>(
      () => _i457.ForgetPasswordViewModel(gh<_i150.ForgetPasswordUseCase>()),
    );
    gh.factory<_i28.DeleteCartCubit>(
      () => _i28.DeleteCartCubit(gh<_i195.DeleteCartItemUseCase>()),
    );
    return this;
  }
}

class _$SharedPreferencesModule extends _i912.SharedPreferencesModule {}

class _$ApiModule extends _i272.ApiModule {}
