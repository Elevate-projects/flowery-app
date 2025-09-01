import 'package:flowery_app/core/app_theme.dart';
import 'package:flowery_app/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloweryApp extends StatelessWidget {
  const FloweryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final startController = BlocProvider.of<GlobalCubit>(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => BlocBuilder<GlobalCubit, GlobalState>(
        buildWhen: (previous, current) => current is LoadedRedirectedScreen,
        builder: (context, state) => state is LoadedRedirectedScreen
            ? MaterialApp(
                title: 'Flowery',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                themeMode: ThemeMode.light,
                onGenerateRoute: AppRoutes.onGenerateRoute,
                initialRoute: startController.redirectedScreen,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
