import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/domain/entities/arguments/occasion_arguments_entitiy.dart';
  import 'package:flowery_app/presentation/auth/login/views/login_view.dart';
import 'package:flowery_app/presentation/home/occasion/view/occasion_view.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteNames.occasionView:

        return MaterialPageRoute(
          builder: (_) => OccasionView(
            occasionArguments: settings.arguments as OccasionArgumentsEntity,
          ),
        );
      default:
        return null;
    }
  }
}
