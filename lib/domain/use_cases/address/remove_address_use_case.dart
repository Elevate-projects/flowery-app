import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/repositories/address/address_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveAddressUseCase {
  final AddressRepository _addressRepository;
  const RemoveAddressUseCase(this._addressRepository);

  Future<Result<void>> invoke({required String addressId}) async {
    return await _addressRepository.removeAddress(addressId: addressId);
  }
}
