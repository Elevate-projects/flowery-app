import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/presentation/auth/forget_password/views/forget_password_screen.dart';
import 'package:flowery_app/presentation/auth/login/views/login_view.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteNames.forgetPassword:
        return MaterialPageRoute(builder: (_) =>   ForgetPasswordScreen());
      default:
        return null;

    }
  }
}
