import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/presentation/auth/login/views/login_view.dart';
import 'package:flowery_app/presentation/auth/register/views/register_view.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      default:
        return null;
    }
  }
}
