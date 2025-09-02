import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/my_bloc_observer.dart';
import 'package:flowery_app/presentation/bottom_navigation%20_bar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'flowery_app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // make sure screen size is initialized before can use it in any widget
  await ScreenUtil.ensureScreenSize();
  // for portrait mode only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // bloc observer for debugging, logging, tracking
  Bloc.observer = MyBlocObserver();
  // get_it dependency injection
  await configureDependencies();
   // remove splash screen after app is loaded
  FlutterNativeSplash.remove();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FloweryApp(),
  ),
  );
}


