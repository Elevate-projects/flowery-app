import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/data/data_source/address/remote_data_source/address_remote_data_source.dart';
import 'package:flowery_app/domain/entities/address/add_address_request_entity.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressRemoteDataSource)
class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final ApiClient _apiClient;

  const AddressRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<void>> removeAddress({required String addressId}) async {
    return executeApi(() async {
      return await _apiClient.removeAddress(
        token: "Bearer ${FloweryMethodHelper.currentUserToken}",
        addressId: addressId,
      );
    });
  }

  @override
  Future<Result<List<AddressEntity>?>> addAddress(
    AddAddressRequestEntity request,
  ) async {
    return executeApi(() async {
      final res = await _apiClient.addAddress(
        request: RequestMapper.addAddressRequestToModel(request),
        token: "Bearer ${FloweryMethodHelper.currentUserToken}",
      );
      return res.address?.map((e) => e.toAddressEntity()).toList();
    });
  }
}
