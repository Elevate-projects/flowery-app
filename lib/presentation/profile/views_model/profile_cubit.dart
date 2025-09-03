import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/profile/get_user_profile_data_use_case.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getUserProfileDataUseCase) : super(const ProfileState());
  final GetUserProfileDataUseCase _getUserProfileDataUseCase;

  Future<void> doIntent({required ProfileIntent intent}) async {
    switch (intent) {
      case ProfileInitializationIntent():
        await _getUserProfileData();
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
}
