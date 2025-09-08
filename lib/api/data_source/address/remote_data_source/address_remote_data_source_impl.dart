import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/address/remote_data_source/address_remote_data_source.dart';
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
}
