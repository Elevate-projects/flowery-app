import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/presentation/auth/forget_password/views/forget_password_screen.dart';
import 'package:flowery_app/presentation/auth/login/views/login_view.dart';
import 'package:flowery_app/presentation/auth/register/views/register_view.dart';
import 'package:flowery_app/presentation/flowery_bottom_navigation/flowery_bottom_navigation.dart';
import 'package:flowery_app/presentation/flowery_bottom_navigation/view_model/flowery_bottom_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteNames.floweryBottomNavigation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<FloweryBottomNavigationCubit>(
            create: (context) => FloweryBottomNavigationCubit(),
            child: const FloweryBottomNavigation(),
          ),
        );
      case RouteNames.forgetPassword:
        return MaterialPageRoute(builder: (_) =>   ForgetPasswordScreen());
      default:
        return null;
    }
  }
}
