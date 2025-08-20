import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/core/global_cubit/global_state.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';

@injectable
class GlobalCubit extends Cubit<GlobalState> {
  final SecureStorage _secureStorage;
  GlobalCubit(this._secureStorage) : super(GlobalInitial());
  late final String redirectedScreen;

  Future<void> onInit() async {
    await setRedirectedScreen();
  }

  Future<void> setRedirectedScreen() async {
    final userToken = await _secureStorage.getData(key: ConstKeys.tokenKey);
    FlutterNativeSplash.remove();
    if (userToken != null) {
      FloweryMethodHelper.currentUserToken = userToken;
      redirectedScreen = RouteNames.splash;
    } else {
      redirectedScreen = RouteNames.login;
    }
    emit(LoadedRedirectedScreen());
  }
}
