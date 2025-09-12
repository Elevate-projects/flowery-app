import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/address/add_address_request_entity.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/domain/repositories/address/address_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAddAddressUseCase {
  AddressRepository addressRepository;

  @factoryMethod
  GetAddAddressUseCase(this.addressRepository);

  Future<Result<List<AddressEntity>?>> execute(
    AddAddressRequestEntity request,
  ) {
    return addressRepository.addAddress(request);
  }
}
