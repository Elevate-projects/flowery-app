import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_app/core/global_cubit/global_intent.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/profile/get_user_profile_data_use_case.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

enum Languages { arabic, english }

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getUserProfileDataUseCase) : super(const ProfileState());
  final GetUserProfileDataUseCase _getUserProfileDataUseCase;

  Future<void> doIntent({required ProfileIntent intent}) async {
    switch (intent) {
      case ProfileInitializationIntent():
        await _onInit(globalCubit: intent.globalCubit);
      case ToggleLanguageIntent():
        await _toggleLanguage(
          globalCubit: intent.globalCubit,
          newSelectedLanguage: intent.newSelectedLanguage,
        );
    }
  }

  Future<void> _onInit({required GlobalCubit globalCubit}) async {
    emit(
      state.copyWith(
        selectedLanguage: globalCubit.isArLanguage
            ? Languages.arabic
            : Languages.english,
      ),
    );
    await _getUserProfileData();
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

  Future<void> _toggleLanguage({
    required GlobalCubit globalCubit,
    required Languages newSelectedLanguage,
  }) async {
    if (newSelectedLanguage != state.selectedLanguage) {
      await globalCubit.doIntent(
        intent: ChangeLanguageIntent(index: state.selectedLanguage.index),
      );
      emit(state.copyWith(selectedLanguage: newSelectedLanguage));
    }
  }
}
