import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/enum/gender.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_intents.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;

  EditProfileCubit(this._editProfileUseCase) : super(const EditProfileState());
  late GlobalKey<FormState> editFormKey;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneNumberController;
  Gender selectedGender = Gender.male; // Initialize with default value instead of late final

  Future<void> doIntent({required EditProfileIntents intent}) async {
    switch (intent) {
      case InitializedEditProfileIntent():
        _init();
        break;
      case EditProfileWithDataIntent():
        _editProfile();
        break;
    }
  }

  void _init() async{
    editFormKey = GlobalKey<FormState>();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    final currentUserData = FloweryMethodHelper.userData;
    firstNameController.text = currentUserData?.firstName ?? '';
    lastNameController.text = currentUserData?.lastName ?? '';
    emailController.text = currentUserData?.email ?? '';
    phoneNumberController.text = currentUserData?.phone ?? '';
   // selectedGender = (currentUserData?.gender as Gender?) ?? Gender.male; // Cast to Gender
  }

  Future<void> _editProfile() async {
    emit(state.copyWith(editProfileState: const StateStatus.loading()));
    final result = await _editProfileUseCase.invoke(
      request: EditProfileRequestEntity(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneNumberController.text,
        // Don't send gender in the request since it can't be changed
      ),
    );
    switch (result) {
      case Success<UserDataEntity>():
        FloweryMethodHelper.userData = result.data;
        emit(state.copyWith(editProfileState: StateStatus.success(null)));
      case Failure<UserDataEntity>():
        emit(
          state.copyWith(
            editProfileState: StateStatus.failure(result.responseException),
          ),
        );
    }
  }
}
