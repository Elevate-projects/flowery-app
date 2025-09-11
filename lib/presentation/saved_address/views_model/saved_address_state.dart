import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';

class SavedAddressState extends Equatable {
  final List<AddressEntity> addresses;
  final StateStatus<void> removeAddressStatus;
  const SavedAddressState({
    this.addresses = const [],
    this.removeAddressStatus = const StateStatus.initial(),
  });

  SavedAddressState copyWith({
    List<AddressEntity>? addresses,
    StateStatus<void>? removeAddressStatus,
  }) {
    return SavedAddressState(
      addresses: addresses ?? this.addresses,
      removeAddressStatus: removeAddressStatus ?? this.removeAddressStatus,
    );
  }

  @override
  List<Object?> get props => [addresses, removeAddressStatus];
}
