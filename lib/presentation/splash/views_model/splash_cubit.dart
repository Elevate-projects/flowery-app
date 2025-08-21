import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/splash/get_user_data_use_case.dart';
import 'package:flowery_app/presentation/splash/views_model/splash_intent.dart';
import 'package:flowery_app/presentation/splash/views_model/splash_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final GetUserDataUseCase _getUserDataUseCase;
  final SecureStorage _secureStorage;
  SplashCubit(this._getUserDataUseCase, this._secureStorage)
    : super(SplashInitial());

  Future<void> doIntent({required SplashIntent intent}) async {
    switch (intent) {
      case GetUserDataIntent():
        await _getUserData();
        break;
      case NavigateToLoginViewIntent():
        await _navigateToLogin();
        break;
    }
  }

  Future<void> _getUserData() async {
    emit(FetchUserDataLoadingState());
    var userData = await _getUserDataUseCase.invoke();
    switch (userData) {
      case Success<UserDataEntity?>():
        FloweryMethodHelper.userData = userData.data;
        emit(FetchUserDataSuccessState());
        break;
      case Failure<UserDataEntity?>():
        emit(FetchUserDataFailureState(errorData: userData.responseException));
        break;
    }
  }

  Future<void> _navigateToLogin() async {
    await _secureStorage.deleteData(key: ConstKeys.tokenKey);
    FloweryMethodHelper.currentUserToken = null;
    FloweryMethodHelper.userData = null;
    emit(LoginNavigationState());
  }
}
