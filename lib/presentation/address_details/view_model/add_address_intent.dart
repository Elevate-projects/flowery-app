import 'package:flowery_app/domain/entities/address/add_address_request_entity.dart';

sealed class AddAddressIntent {}

class OnAddAddressInitializationIntent extends AddAddressIntent {
  final AddAddressRequestEntity request;

  OnAddAddressInitializationIntent(this.request);
}

class LoadCitiesAndAreasIntent extends AddAddressIntent {}

class SelectCityIntent extends AddAddressIntent {
  final String city;

  SelectCityIntent(this.city);
}

class SelectAreaIntent extends AddAddressIntent {
  final String area;

  SelectAreaIntent(this.area);
}

class EnableAutoValidateIntent extends AddAddressIntent {}

class DisableAutoValidateIntent extends AddAddressIntent {}
