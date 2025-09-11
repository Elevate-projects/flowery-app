import 'package:flowery_app/domain/entities/address/address_entity.dart';

sealed class SavedAddressIntent {}

class SavedAddressInitializationIntent extends SavedAddressIntent {
  final List<AddressEntity> addresses;
  SavedAddressInitializationIntent({required this.addresses});
}

class RemoveAddressIntent extends SavedAddressIntent {
  final String addressId;
  RemoveAddressIntent({required this.addressId});
}
