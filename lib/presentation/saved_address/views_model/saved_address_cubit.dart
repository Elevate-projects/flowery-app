import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/domain/use_cases/address/remove_address_use_case.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_intent.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavedAddressCubit extends Cubit<SavedAddressState> {
  final RemoveAddressUseCase _removeAddressUseCase;
  SavedAddressCubit(this._removeAddressUseCase)
    : super(const SavedAddressState());

  Future<void> doIntent({required SavedAddressIntent intent}) async {
    switch (intent) {
      case SavedAddressInitializationIntent():
        _initializingAddressesList(addresses: intent.addresses);
      case RemoveAddressIntent():
        await _removeAddress(addressId: intent.addressId);
    }
  }

  void _initializingAddressesList({required List<AddressEntity> addresses}) {
    emit(state.copyWith(addresses: addresses));
  }

  Future<void> _removeAddress({required String addressId}) async {
    emit(state.copyWith(removeAddressStatus: const StateStatus.loading()));
    final result = await _removeAddressUseCase.invoke(addressId: addressId);
    if (isClosed) return;
    switch (result) {
      case Success<void>():
        FloweryMethodHelper.userData?.addresses?.removeWhere(
          (address) => address.id == addressId,
        );
        emit(
          state.copyWith(removeAddressStatus: const StateStatus.success(null)),
        );
      case Failure<void>():
        emit(
          state.copyWith(
            removeAddressStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }
}
