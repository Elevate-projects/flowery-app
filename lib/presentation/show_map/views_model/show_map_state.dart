import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

final class ShowMapState extends Equatable {
  final List<LatLng> polylinePoints;
  final LatLng? storeLocation;
  final LatLng? userLocation;

  const ShowMapState({
    this.storeLocation,
    this.userLocation,
    this.polylinePoints = const [],
  });

  ShowMapState copyWith({
    List<LatLng>? polylinePoints,
    LatLng? storeLocation,
    LatLng? userLocation,
  }) {
    return ShowMapState(
      polylinePoints: polylinePoints ?? this.polylinePoints,
      storeLocation: storeLocation ?? this.storeLocation,
      userLocation: userLocation ?? this.userLocation,
    );
  }

  @override
  List<Object?> get props => [polylinePoints, storeLocation, userLocation];
}
