import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressState extends Equatable {
  final StateStatus<void> addAddressStatus;
  final StateStatus<void> loadCitiesAndAreasStatus;
  final LatLng selectedLocation;
  final String address;
  final List<String> cities;
  final List<String> areas;
  final String? selectedCity;
  final String? selectedArea;
  final AutovalidateMode autoValidateMode;

  const AddAddressState({
    this.addAddressStatus = const StateStatus.initial(),
    this.loadCitiesAndAreasStatus = const StateStatus.initial(),
    this.selectedLocation = const LatLng(30.0444, 31.2357),
    this.address = '',
    this.cities = const [],
    this.areas = const [],
    this.selectedCity,
    this.selectedArea,
    this.autoValidateMode = AutovalidateMode.disabled,
  });

  AddAddressState copyWith({
    StateStatus<void>? addAddressStatus,
    StateStatus<void>? loadCitiesAndAreasStatus,
    LatLng? selectedLocation,
    String? address,
    List<String>? cities,
    List<String>? areas,
    String? selectedCity,
    String? selectedArea,
    AutovalidateMode? autoValidateMode,
  }) {
    return AddAddressState(
      addAddressStatus: addAddressStatus ?? this.addAddressStatus,
      loadCitiesAndAreasStatus:
          loadCitiesAndAreasStatus ?? this.loadCitiesAndAreasStatus,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      address: address ?? this.address,
      cities: cities ?? this.cities,
      areas: areas ?? this.areas,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedArea: selectedArea ?? this.selectedArea,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }

  @override
  List<Object?> get props => [
    addAddressStatus,
    loadCitiesAndAreasStatus,
    selectedLocation,
    address,
    cities,
    areas,
    selectedCity,
    selectedArea,
    autoValidateMode,
  ];
}
