import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/address/remote_data_source/address_remote_data_source.dart';
import 'package:flowery_app/domain/repositories/address/address_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressRepository)
class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource _addressRemoteDataSource;
  const AddressRepositoryImpl(this._addressRemoteDataSource);

  @override
  Future<Result<void>> removeAddress({required String addressId}) async {
    return await _addressRemoteDataSource.removeAddress(addressId: addressId);
  }
}
