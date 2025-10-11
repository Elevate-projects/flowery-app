import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class MapState extends Equatable {
  final bool isLoading;
  final LatLng? currentLocation;
  final LatLng? destination;
  final List<LatLng> routePoints;

  const MapState({
    required this.isLoading,
    required this.currentLocation,
    required this.destination,
    required this.routePoints,
  });

  factory MapState.initial() => const MapState(
    isLoading: true,
    currentLocation: null,
    destination: null,
    routePoints: [],
  );

  @override
  List<Object?> get props => [isLoading, currentLocation, destination, routePoints];
}