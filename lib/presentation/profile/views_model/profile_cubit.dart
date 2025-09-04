import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/logout/logout_use_case.dart';
import 'package:flowery_app/domain/use_cases/profile/get_user_profile_data_use_case.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._getUserProfileDataUseCase,
    this._logoutUseCase,
    this._secureStorage,
  ) : super(const ProfileState());
  final GetUserProfileDataUseCase _getUserProfileDataUseCase;
  final LogoutUseCase _logoutUseCase;
  final SecureStorage _secureStorage;

  Future<void> doIntent({required ProfileIntent intent}) async {
    switch (intent) {
      case ProfileInitializationIntent():
        await _getUserProfileData();
      case LogoutIntent():
        await _logout();
    }
  }

  Future<void> _getUserProfileData() async {
    if (FloweryMethodHelper.userData == null) {
      emit(state.copyWith(profileStatus: const StateStatus.loading()));
      final result = await _getUserProfileDataUseCase.invoke();
      if (isClosed) return;
      switch (result) {
        case Success<UserDataEntity?>():
          FloweryMethodHelper.userData = result.data;
          emit(state.copyWith(profileStatus: const StateStatus.success(null)));
        case Failure<UserDataEntity?>():
          emit(
            state.copyWith(
              profileStatus: StateStatus.failure(result.responseException),
            ),
          );
      }
    }
  }

  Future<void> _logout() async {
    emit(state.copyWith(logoutStatus: const StateStatus.loading()));
    final result = await _logoutUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<void>():
        await _removeUserData();
        emit(state.copyWith(logoutStatus: const StateStatus.success(null)));
      case Failure<void>():
        emit(
          state.copyWith(
            logoutStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }

  Future<void> _removeUserData() async {
    await _secureStorage.deleteData(key: ConstKeys.tokenKey);
    FloweryMethodHelper.currentUserToken = null;
    FloweryMethodHelper.userData = null;
  }
}
