import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/profile/get_user_profile_data_use_case.dart';
import 'package:flowery_app/presentation/checkout/views_model/address_cubit/address_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressCubit extends Cubit<AddressState> {
  final GetUserProfileDataUseCase _getUserProfileDataUseCase;
  AddressCubit(this._getUserProfileDataUseCase) : super(InitialAddressState()) {
    if (FloweryMethodHelper.userData == null) fetchAddress();
  }
  int selectedIndex = 0;

  void selectAddress(int index) {
    selectedIndex = index;
    emit(ChangeAddressIndexState(index));
  }

  void updateAddress() {
    emit(UpdateAddressState());
  }

  Future<void> fetchAddress() async {
    emit(FetchAddressLoadingState());
    final result = await _getUserProfileDataUseCase.invoke();
    switch (result) {
      case Success<UserDataEntity?>():
        FloweryMethodHelper.userData = result.data;
        emit(FetchAddressSuccessState());
      case Failure<UserDataEntity?>():
        emit(FetchAddressFailureState(error: result.responseException));
    }
  }
}
