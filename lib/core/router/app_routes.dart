import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/presentation/auth/login/views/login_view.dart';
import 'package:flowery_app/presentation/auth/verification/views/email_verfication.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/auth/reset_password/view_model/reset_password_cubit.dart';
import '../../presentation/auth/reset_password/views/reset_password.dart';
import '../../presentation/home/best_seller/view/best_seller_view.dart';
import '../../presentation/home/best_seller/view_model/best_seller_cubit.dart';

abstract class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteNames.verification:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<VerificationScreenCubit>(),
            child: EmailVerification(),
          ),
        );
      case RouteNames.resetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ResetPasswordCubit>(),
            child: ResetPassword(email: settings.arguments as String),
          ),
        );
      case RouteNames.bestSeller:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<BestSellerCubit>(),
            child: const BestSellerView(),
          ),
        );
      default:
        return null;
    }
  }
}
