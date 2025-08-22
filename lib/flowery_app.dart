import 'package:flowery_app/core/app_theme.dart';
import 'package:flowery_app/core/router/app_routes.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloweryApp extends StatelessWidget {
  const FloweryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Flowery',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: RouteNames.forgetPassword,
      ),
    );
  }
}
