import 'package:flowery_app/presentation/checkout/views_model/address_cubit/address_cubit.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_cubit.dart';

class AddressArgumentEntity {
  AddressArgumentEntity({
    this.isAddedFromCheckout = false,
    this.savedAddressCubit,
    this.addressCubit,
  });
  final bool isAddedFromCheckout;
  final SavedAddressCubit? savedAddressCubit;
  final AddressCubit? addressCubit;
}
