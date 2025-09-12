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
import '../../api/data_source/add_to_cart/remote_data_source/add_to_cart_remote_data_source_impl.dart'
    as _i187;
import '../../api/data_source/address/remote_data_source/address_remote_data_source_impl.dart'
    as _i188;
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
import '../../api/data_source/home_products/home_products_data_source_impl.dart'
    as _i81;
import '../../api/data_source/login/remote_data_source/login_remote_data_source_impl.dart'
    as _i221;
import '../../api/data_source/logout/remote_data_source/logout_remote_data_source_impl.dart'
    as _i340;
import '../../api/data_source/profile/remote_data_source/profile_remote_data_source_impl.dart'
    as _i913;
import '../../api/data_source/register/remote_data_source/register_remote_data_source_impl.dart'
    as _i281;
import '../../api/data_source/resend_code/resend_code_data_source_impl.dart'
    as _i53;
import '../../api/data_source/reset_password/reset_password_data_source_impl.dart'
    as _i783;
import '../../api/data_source/search_data_source/search_data_source_impl.dart'
    as _i553;
import '../../api/data_source/verification/verification_data_source_impl.dart'
    as _i15;
import '../../data/data_source/add_to_cart/remote_data_source/add_to_cart_remote_data_source.dart'
    as _i819;
import '../../data/data_source/address/remote_data_source/address_remote_data_source.dart'
    as _i1025;
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
import '../../data/data_source/home_products/home_products_data_source.dart'
    as _i950;
import '../../data/data_source/login/remote_data_source/login_remote_data_source.dart'
    as _i684;
import '../../data/data_source/logout/remote_data_source/logout_remote_data_source.dart'
    as _i924;
import '../../data/data_source/profile/remote_data_source/profile_remote_data_source.dart'
    as _i470;
import '../../data/data_source/register/remote_data_source/register_remote_data_source.dart'
    as _i233;
import '../../data/data_source/resend_code/resend_code_data_source.dart'
    as _i523;
import '../../data/data_source/reset_password/reset_password_data_source.dart'
    as _i926;
import '../../data/data_source/search_data_source/search_data_source.dart'
    as _i40;
import '../../data/data_source/verification/verification_data_source.dart'
    as _i14;
import '../../data/repositories/add_to_cart/add_to_cart_repository_impl.dart'
    as _i585;
import '../../data/repositories/address/address_repository_impl.dart' as _i444;
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
import '../../data/repositories/home_products/home_products_repository_impl_.dart'
    as _i713;
import '../../data/repositories/login/login_repository_impl.dart' as _i722;
import '../../data/repositories/logout/logout_repository_impl.dart' as _i463;
import '../../data/repositories/profile/profile_repository_impl.dart' as _i770;
import '../../data/repositories/register/register_repository_impl.dart' as _i40;
import '../../data/repositories/resend_code/resend_code_repository_impl.dart'
    as _i622;
import '../../data/repositories/reset_password/reset_password_repository_impl.dart'
    as _i50;
import '../../data/repositories/search/search_repo_impl.dart' as _i754;
import '../../data/repositories/verification/verification_repository_impl.dart'
    as _i1003;
import '../../domain/repositories/add_to_cart/add_to_cart_repository.dart'
    as _i475;
import '../../domain/repositories/address/address_repository.dart' as _i119;
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
import '../../domain/repositories/home_products/home_products_repository.dart'
    as _i168;
import '../../domain/repositories/login/login_repository.dart' as _i300;
import '../../domain/repositories/logout/logout_repository.dart' as _i6;
import '../../domain/repositories/profile/profile_repository.dart' as _i445;
import '../../domain/repositories/register/register_repository.dart' as _i638;
import '../../domain/repositories/resend_code/resend_code.dart' as _i673;
import '../../domain/repositories/reset_password/reset_password_repository.dart'
    as _i189;
import '../../domain/repositories/search/search_repo.dart' as _i800;
import '../../domain/repositories/verification/verification_repository.dart'
    as _i550;
import '../../domain/use_cases/add_to_cart/add_product_to_cart_use_case.dart'
    as _i334;
import '../../domain/use_cases/address/add_address_use_case.dart' as _i1000;
import '../../domain/use_cases/address/remove_address_use_case.dart' as _i20;
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
import '../../domain/use_cases/home_products/home_products_use_case.dart'
    as _i627;
import '../../domain/use_cases/login/login_with_email_and_password_use_case.dart'
    as _i197;
import '../../domain/use_cases/logout/logout_use_case.dart' as _i242;
import '../../domain/use_cases/profile/get_user_profile_data_use_case.dart'
    as _i306;
import '../../domain/use_cases/register/register_use_case.dart' as _i950;
import '../../domain/use_cases/resend_code/resend_code_usecase.dart' as _i335;
import '../../domain/use_cases/reset_password/reset_password_usecase.dart'
    as _i963;
import '../../domain/use_cases/search/search_use_case.dart' as _i612;
import '../../domain/use_cases/verification/verification_usecase.dart' as _i510;
import '../../presentation/about_us/views_model/about_us_cubit.dart' as _i225;
import '../../presentation/address_details/view_model/add_address_cubit.dart'
    as _i92;
import '../../presentation/auth/forget_password/views_model/forget_password_view_model.dart'
    as _i457;
import '../../presentation/auth/login/views_model/login_cubit.dart' as _i512;
import '../../presentation/auth/register/view_model/register_cubit.dart'
    as _i536;
import '../../presentation/auth/reset_password/view_model/reset_password_cubit.dart'
    as _i349;
import '../../presentation/auth/verification/views_model/verification_screen_cubit.dart'
    as _i988;
import '../../presentation/cart/view_model/cart_cubit.dart' as _i764;
import '../../presentation/cart/view_model/delete_cubit/delete_cubit.dart'
    as _i28;
import '../../presentation/cart/view_model/quantity_cubit/quantity_cubit.dart'
    as _i46;
import '../../presentation/categories/views_model/categories_cubit.dart'
    as _i200;
import '../../presentation/checkout_page/view_model/checkout_cubit/checkout_view_model.dart'
    as _i504;
import '../../presentation/home/home_screen/view_model/home_products_cubit.dart'
    as _i641;
import '../../presentation/home/occasions/view_model/occasion_view_model.dart'
    as _i694;
import '../../presentation/product_details/views_model/product_details_cubit.dart'
    as _i586;
import '../../presentation/profile/views_model/profile_cubit.dart' as _i1028;
import '../../presentation/saved_address/views_model/saved_address_cubit.dart'
    as _i46;
import '../../presentation/search/search/view_model/search_view_model.dart'
    as _i484;
import '../../presentation/terms_and_conditions/views_model/terms_and_conditions_cubit.dart'
    as _i297;
import '../../utils/common_cubits/add_product_to_cart/add_product_to_cart_cubit.dart'
    as _i1028;
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
    gh.factory<_i694.OccasionsViewModel>(() => _i694.OccasionsViewModel());
    gh.factory<_i586.ProductDetailsCubit>(() => _i586.ProductDetailsCubit());
    gh.factory<_i297.TermsAndConditionsCubit>(
      () => _i297.TermsAndConditionsCubit(),
    );
    gh.factory<_i504.GiftSwitchCubit>(() => _i504.GiftSwitchCubit());
    gh.singleton<_i361.Dio>(() => apiModule.provideDio());
    gh.singleton<_i23.SecureStorage>(() => _i23.SecureStorage());
    gh.factory<_i508.ApiClient>(() => _i508.ApiClient(gh<_i361.Dio>()));
    gh.factory<_i523.ResendCodeDataSource>(
      () => _i53.ResendCodeDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i819.AddToCartRemoteDataSource>(
      () => _i187.AddToCartRemoteDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.singleton<_i686.SharedPreferencesHelper>(
      () => _i686.SharedPreferencesHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i475.AddToCartRepository>(
      () =>
          _i585.AddToCartRepositoryImpl(gh<_i819.AddToCartRemoteDataSource>()),
    );
    gh.factory<_i14.VerificationDataSource>(
      () => _i15.VerificationDataSourceImpl(gh<_i508.ApiClient>()),
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
    gh.factory<_i926.ResetPasswordDataSource>(
      () => _i783.ResetPasswordDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i40.SearchDataSource>(
      () => _i553.SearchDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i950.HomeProductsDataSource>(
      () => _i81.HomeProductsDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i673.ResendCodeRepository>(
      () => _i622.ResendCodeRepositoryImpl(gh<_i523.ResendCodeDataSource>()),
    );
    gh.factory<_i849.ForgetPasswordRemoteDataSource>(
      () => _i428.ForgetPasswordRemoteDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i334.AddProductToCartUseCase>(
      () => _i334.AddProductToCartUseCase(gh<_i475.AddToCartRepository>()),
    );
    gh.factory<_i470.ProfileRemoteDataSource>(
      () => _i913.ProfileRemoteDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i631.RemoteDataSourceDeleteItem>(
      () =>
          _i618.RemoteDataSourceDeleteItemImp(apiClient: gh<_i508.ApiClient>()),
    );
    gh.factory<_i1025.AddressRemoteDataSource>(
      () => _i188.AddressRemoteDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i119.AddressRepository>(
      () => _i444.AddressRepositoryImpl(gh<_i1025.AddressRemoteDataSource>()),
    );
    gh.factory<_i924.LogoutRemoteDataSource>(
      () => _i340.LogoutRemoteDataSourceImpl(gh<_i508.ApiClient>()),
    );
    gh.factory<_i335.GetResendCodeUseCase>(
      () => _i335.GetResendCodeUseCase(gh<_i673.ResendCodeRepository>()),
    );
    gh.factory<_i1028.AddProductToCartCubit>(
      () => _i1028.AddProductToCartCubit(gh<_i334.AddProductToCartUseCase>()),
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
    gh.factory<_i445.ProfileRepository>(
      () => _i770.ProfileRepositoryImpl(gh<_i470.ProfileRemoteDataSource>()),
    );
    gh.factory<_i20.RemoveAddressUseCase>(
      () => _i20.RemoveAddressUseCase(gh<_i119.AddressRepository>()),
    );
    gh.factory<_i550.VerificationRepository>(
      () =>
          _i1003.VerificationRepositoryImpl(gh<_i14.VerificationDataSource>()),
    );
    gh.factory<_i168.HomeProductsRepository>(
      () =>
          _i713.HomeProductsRepositoryImpl(gh<_i950.HomeProductsDataSource>()),
    );
    gh.factory<_i378.RemoveQuantityRepositories>(
      () => _i954.QuantityRepositoriesImp(
        gh<_i879.RemoteDataSourceQuantityRequest>(),
      ),
    );
    gh.factory<_i757.CartRepository>(
      () => _i112.CartRepositoryImpl(gh<_i691.RemoteDataSourceGetLoggedUser>()),
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
    gh.factory<_i189.ResetPasswordRepository>(
      () =>
          _i50.ResetPasswordRepositoryImpl(gh<_i926.ResetPasswordDataSource>()),
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
    gh.factory<_i510.GetVerificationUseCase>(
      () => _i510.GetVerificationUseCase(gh<_i550.VerificationRepository>()),
    );
    gh.factory<_i800.SearchRepo>(
      () => _i754.SearchRepoImpl(gh<_i40.SearchDataSource>()),
    );
    gh.factory<_i46.QuantityCubit>(
      () => _i46.QuantityCubit(gh<_i618.QuantityUseCase>()),
    );
    gh.factory<_i6.LogoutRepository>(
      () => _i463.LogoutRepositoryImpl(gh<_i924.LogoutRemoteDataSource>()),
    );
    gh.factory<_i988.VerificationScreenCubit>(
      () => _i988.VerificationScreenCubit(
        gh<_i335.GetResendCodeUseCase>(),
        gh<_i510.GetVerificationUseCase>(),
      ),
    );
    gh.factory<_i330.DeleteItemRepositories>(
      () =>
          _i6.DeleteItemRepositoriesImp(gh<_i631.RemoteDataSourceDeleteItem>()),
    );
    gh.factory<_i1000.GetAddAddressUseCase>(
      () => _i1000.GetAddAddressUseCase(gh<_i119.AddressRepository>()),
    );
    gh.factory<_i963.GetResetPasswordUseCase>(
      () => _i963.GetResetPasswordUseCase(gh<_i189.ResetPasswordRepository>()),
    );
    gh.factory<_i612.SearchUseCase>(
      () => _i612.SearchUseCase(gh<_i800.SearchRepo>()),
    );
    gh.factory<_i764.CartCubit>(
      () => _i764.CartCubit(gh<_i257.GetLoggedUserCartUseCase>()),
    );
    gh.factory<_i92.AddAddressCubit>(
      () => _i92.AddAddressCubit(gh<_i1000.GetAddAddressUseCase>()),
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
    gh.factory<_i46.SavedAddressCubit>(
      () => _i46.SavedAddressCubit(gh<_i20.RemoveAddressUseCase>()),
    );
    gh.factory<_i349.ResetPasswordCubit>(
      () => _i349.ResetPasswordCubit(gh<_i963.GetResetPasswordUseCase>()),
    );
    gh.factory<_i484.SearchViewModel>(
      () => _i484.SearchViewModel(gh<_i612.SearchUseCase>()),
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
    gh.factory<_i242.LogoutUseCase>(
      () => _i242.LogoutUseCase(gh<_i6.LogoutRepository>()),
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
    gh.factory<_i1028.ProfileCubit>(
      () => _i1028.ProfileCubit(
        gh<_i306.GetUserProfileDataUseCase>(),
        gh<_i242.LogoutUseCase>(),
        gh<_i23.SecureStorage>(),
      ),
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
