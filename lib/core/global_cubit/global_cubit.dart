import 'package:flowery_app/core/cache/shared_preferences_helper.dart';
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
  final SharedPreferencesHelper _sharedPreferencesHelper;
  GlobalCubit(this._secureStorage, this._sharedPreferencesHelper)
    : super(GlobalInitial());
  late final String redirectedScreen;

  Future<void> onInit() async {
    await setRedirectedScreen();
  }

  Future<void> setRedirectedScreen() async {
    final userToken = await _secureStorage.getData(key: ConstKeys.tokenKey);
    final isRemembered = _sharedPreferencesHelper.getBool(
      key: ConstKeys.rememberMe,
    );
    FlutterNativeSplash.remove();
    if (userToken != null && isRemembered) {
      FloweryMethodHelper.currentUserToken = userToken;
      redirectedScreen = RouteNames.floweryBottomNavigation;
    } else {
      redirectedScreen = RouteNames.login;
    }
    emit(LoadedRedirectedScreen());
  }
}
