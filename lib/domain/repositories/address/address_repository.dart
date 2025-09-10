import 'package:flowery_app/api/client/api_result.dart';

abstract class AddressRepository {
  Future<Result<void>> removeAddress({required String addressId});
}
