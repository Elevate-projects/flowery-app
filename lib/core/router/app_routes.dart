import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/presentation/auth/login/views/login_view.dart';
import 'package:flowery_app/presentation/product_details/views/product_details_view.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteNames.productDetails:
        return MaterialPageRoute(builder: (_) => const ProductDetailsView());
      default:
        return null;
    }
  }
}
