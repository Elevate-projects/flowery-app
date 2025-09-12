import 'dart:convert';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/constants/json_screens.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/address/add_address_request_entity.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/domain/use_cases/address/add_address_use_case.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_intent.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAddressCubit extends Cubit<AddAddressState> {
  final GetAddAddressUseCase _getAddAddressUseCase;

  AddAddressCubit(this._getAddAddressUseCase) : super(const AddAddressState());

  void doIntent(AddAddressIntent intent) async {
    switch (intent) {
      case OnAddAddressInitializationIntent():
        return _addAddress(intent.request);
      case LoadCitiesAndAreasIntent():
        return await _loadCitiesAndAreasData();
      case SelectCityIntent():
        emit(state.copyWith(selectedCity: intent.city));
      case SelectAreaIntent():
        emit(state.copyWith(selectedArea: intent.area));
      case EnableAutoValidateIntent():
        emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
      case DisableAutoValidateIntent():
        emit(state.copyWith(autoValidateMode: AutovalidateMode.disabled));
    }
  }

  Future<void> selectLocation(LatLng position) async {
    emit(state.copyWith(selectedLocation: position));

    try {
      final placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final place = placeMarks.first;
      final address =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

      emit(state.copyWith(address: address));
    } catch (e) {
      emit(state.copyWith(address: ''));
    }
  }

  Future<void> _loadCitiesAndAreasData() async {
    try {
      emit(
        state.copyWith(loadCitiesAndAreasStatus: const StateStatus.loading()),
      );
      final jsonCitiesString = await rootBundle.loadString(JsonScreens.cities);
      final jsonAreasString = await rootBundle.loadString(JsonScreens.states);

      final citiesData = json.decode(jsonCitiesString) as List<dynamic>;

      final areasData = json.decode(jsonAreasString) as List<dynamic>;
      final citiesTable = citiesData.firstWhere(
        (e) => e["type"] == "table" && e["name"] == "governorates",
      );
      final areasTable = areasData.firstWhere(
        (e) => e["type"] == "table" && e["name"] == "cities",
      );
      final List<String> cities = (citiesTable["data"] as List)
          .map((e) => e["governorate_name_en"].toString())
          .toList();
      final List<String> areas = (areasTable["data"] as List)
          .map((e) => e["city_name_en"].toString())
          .toList();

      emit(
        state.copyWith(
          cities: cities,
          areas: areas,
          loadCitiesAndAreasStatus: const StateStatus.success(null),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          loadCitiesAndAreasStatus: StateStatus.failure(
            ResponseException(
              message: "${AppText.unexpectedError} ${error.toString()}",
            ),
          ),
        ),
      );
    }
  }

  void _addAddress(AddAddressRequestEntity request) async {
    emit(state.copyWith(addAddressStatus: const StateStatus.loading()));
    final res = await _getAddAddressUseCase.execute(request);
    switch (res) {
      case Success<List<AddressEntity>?>():
        FloweryMethodHelper.userData?.addresses?.add(res.data!.last);
        emit(state.copyWith(addAddressStatus: const StateStatus.success(null)));
        emit(state.copyWith(addAddressStatus: const StateStatus.initial()));
      case Failure<List<AddressEntity>?>():
        emit(
          state.copyWith(
            addAddressStatus: StateStatus.failure(res.responseException),
          ),
        );
        emit(state.copyWith(addAddressStatus: const StateStatus.initial()));
    }
  }
}
