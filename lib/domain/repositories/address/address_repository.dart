import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/address/add_address_request_entity.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';

abstract class AddressRepository {
  Future<Result<void>> removeAddress({required String addressId});

  Future<Result<List<AddressEntity>?>> addAddress(AddAddressRequestEntity request);
}
