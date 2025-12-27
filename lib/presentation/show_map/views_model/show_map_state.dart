import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:latlong2/latlong.dart';

final class ShowMapState extends Equatable {
  final StateStatus<void> mapStatus;
  final List<LatLng> polylinePoints;
  final LatLng? driverLocation;
  final LatLng? userLocation;

  const ShowMapState({
    this.mapStatus = const StateStatus.initial(),
    this.driverLocation,
    this.userLocation,
    this.polylinePoints = const [],
  });

  ShowMapState copyWith({
    StateStatus<void>? mapStatus,
    List<LatLng>? polylinePoints,
    LatLng? driverLocation,
    LatLng? userLocation,
  }) {
    return ShowMapState(
      mapStatus: mapStatus ?? this.mapStatus,
      polylinePoints: polylinePoints ?? this.polylinePoints,
      driverLocation: driverLocation ?? this.driverLocation,
      userLocation: userLocation ?? this.userLocation,
    );
  }

  @override
  List<Object?> get props => [
    mapStatus,
    polylinePoints,
    driverLocation,
    userLocation,
  ];
}
