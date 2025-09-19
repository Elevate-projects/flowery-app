import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/domain/entities/arguments/occasion_arguments_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/presentation/about_us/views/about_us_view.dart';
import 'package:flowery_app/presentation/address_details/view/address_details.dart';
import 'package:flowery_app/presentation/auth/forget_password/views/forget_password_screen.dart';
import 'package:flowery_app/presentation/auth/login/views/login_view.dart';
import 'package:flowery_app/presentation/auth/register/views/register_view.dart';
import 'package:flowery_app/presentation/auth/reset_password/view_model/reset_password_cubit.dart';
import 'package:flowery_app/presentation/auth/reset_password/views/reset_password.dart';
import 'package:flowery_app/presentation/auth/verification/views/email_verfication.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flowery_app/presentation/checkout/views/checkout_view.dart';
import 'package:flowery_app/presentation/edit_profile/views/edit_profile_view.dart';
import 'package:flowery_app/presentation/flowery_bottom_navigation/flowery_bottom_navigation.dart';
import 'package:flowery_app/presentation/flowery_bottom_navigation/view_model/flowery_bottom_navigation_cubit.dart';
import 'package:flowery_app/presentation/home/best_seller/view/best_seller_view.dart';
import 'package:flowery_app/presentation/home/occasions/view/occasion_view.dart';
import 'package:flowery_app/presentation/notification_list/view/notification_list.dart';
import 'package:flowery_app/presentation/product_details/views/product_details_view.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_app/presentation/saved_address/views/saved_address_view.dart';
import 'package:flowery_app/presentation/search/search/view/search_view.dart';
import 'package:flowery_app/presentation/terms_and_conditions/views/terms_and_conditions_view.dart';
import 'package:flowery_app/utils/common_cubits/add_product_to_cart/add_product_to_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteNames.aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutUsView());
      case RouteNames.termsAndConditions:
        return MaterialPageRoute(
          builder: (_) => const TermsAndConditionsView(),
        );
      case RouteNames.productDetails:
        return MaterialPageRoute(
          builder: (_) => ProductDetailsView(
            productCardData: settings.arguments as ProductCardEntity,
          ),
        );
      case RouteNames.floweryBottomNavigation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<FloweryBottomNavigationCubit>(
            create: (context) => FloweryBottomNavigationCubit(),
            child: const FloweryBottomNavigation(),
          ),
        );
      case RouteNames.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case RouteNames.bestSeller:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt.get<AddProductToCartCubit>(),
            child: BestSellerView(
              products: settings.arguments as List<ProductCardEntity>,
            ),
          ),
        );
      case RouteNames.occasionView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt.get<AddProductToCartCubit>(),
            child: OccasionView(
              occasionArguments: settings.arguments as OccasionArgumentsEntity,
            ),
          ),
        );
      case RouteNames.verification:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<VerificationScreenCubit>(),
            child: const EmailVerification(),
          ),
        );
      case RouteNames.resetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ResetPasswordCubit>(),
            child: ResetPassword(email: settings.arguments as String),
          ),
        );
      case RouteNames.savedAddress:
        return MaterialPageRoute(
          builder: (_) => SavedAddressView(
            addresses: settings.arguments as List<AddressEntity>,
          ),
        );
      case RouteNames.addressDetails:
        return MaterialPageRoute(builder: (_) => const AddressDetails());
      case RouteNames.checkout:
        return MaterialPageRoute(
          builder: (_) => CheckoutView(subTotal: settings.arguments as int),
        );
      case RouteNames.editProfile:
        return MaterialPageRoute(
          builder: (_) =>
              EditProfileView(profileCubit: settings.arguments as ProfileCubit),
        );

      case RouteNames.searchView:
        return MaterialPageRoute(builder: (context) => const SearchView());
      case RouteNames.notificationList:
        return MaterialPageRoute(
          builder: (context) => const NotificationList(),
        );
      default:
        return null;
    }
  }
}
