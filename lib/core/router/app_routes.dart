import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/presentation/about_us/views/about_us_view.dart';
import 'package:flowery_app/presentation/auth/forget_password/views/forget_password_screen.dart';
import 'package:flowery_app/presentation/auth/login/views/login_view.dart';
import 'package:flowery_app/presentation/auth/register/views/register_view.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_intents.dart';
import 'package:flowery_app/presentation/edit_profile/views/edit_profile_view.dart';
import 'package:flowery_app/presentation/flowery_bottom_navigation/flowery_bottom_navigation.dart';
import 'package:flowery_app/presentation/flowery_bottom_navigation/view_model/flowery_bottom_navigation_cubit.dart';
import 'package:flowery_app/presentation/product_details/views/product_details_view.dart';
import 'package:flowery_app/presentation/terms_and_conditions/views/terms_and_conditions_view.dart';
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
      case RouteNames.editProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<EditProfileCubit>(
            create: (context) => getIt.get<EditProfileCubit>()
            ..doIntent(intent: InitializedEditProfileIntent()),
            child: const EditProfileView(),
          ),
        );
      default:
        return null;
    }
  }
}
