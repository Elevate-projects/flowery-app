import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/presentation/auth/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/bottom_navigation _bar/bottom_navigation_bar.dart';
import '../../presentation/bottom_navigation _bar/view_model/bottom_cubit.dart';

abstract class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteNames.bottomNavigation:
        return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (context) => BottomCubit(),
            child: const FloweryBottomNavigationBar()));
      default:
        return null;
    }
  }}
