import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';

sealed class AddressState {}

class InitialAddressState extends AddressState {}

class ChangeAddressIndexState extends AddressState with EquatableMixin {
  final int index;
  ChangeAddressIndexState(this.index);
  @override
  List<Object?> get props => [index];
}

class UpdateAddressState extends AddressState {}

class FetchAddressLoadingState extends AddressState {}

class FetchAddressSuccessState extends AddressState {}

class FetchAddressFailureState extends AddressState {
  FetchAddressFailureState({required this.error});
  final ResponseException error;
}
