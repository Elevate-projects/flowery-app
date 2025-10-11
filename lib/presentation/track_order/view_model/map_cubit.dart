import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' hide LocationAccuracy;
import 'package:flowery_app/presentation/track_order/view_model/map_state.dart';
class MapCubit extends Cubit<MapState> {
  final Location _location = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  LatLng? _destination;
  late final MapController controller;

  MapCubit() : super(MapState.initial()) {
    controller = MapController();
  }

  Future<void> initializeLocation(double destinationLat, double destinationLon) async {
    if (!await _checkLocationPermission()) {
      return;
    }

    _destination = LatLng(destinationLat, destinationLon);
    emit(MapState(
      isLoading: state.isLoading,
      currentLocation: state.currentLocation,
      destination: _destination,
      routePoints: state.routePoints,
    ));

    _locationSubscription = _location.onLocationChanged.listen((LocationData locationData) async {
      if (locationData.latitude != null && locationData.longitude != null) {
        final newCurrentLocation = LatLng(locationData.latitude!, locationData.longitude!);

        emit(MapState(
          isLoading: false,
          currentLocation: newCurrentLocation,
          destination: _destination,
          routePoints: state.routePoints,
        ));
        if (_destination != null) {
          await calculateRoute();
        }
      }
    });
  }

  Future<void> calculateRoute() async {
    if (state.currentLocation == null || _destination == null) return;

    final url = Uri.parse(
      'http://router.project-osrm.org/route/v1/driving/'
          '${state.currentLocation!.longitude.toStringAsFixed(6)},${state.currentLocation!.latitude.toStringAsFixed(6)};'
          '${_destination!.longitude.toStringAsFixed(6)},${_destination!.latitude.toStringAsFixed(6)}'
          '?overview=full&geometries=polyline',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry'];
      _decodePolyline(geometry);
    } else {
      return Future.error('Route fetch failed: ${response.body}');
    }
  }

  void _decodePolyline(String encodedPolyline) {
    final List<PointLatLng> decodedPoints = PolylinePoints.decodePolyline(encodedPolyline);
    final newRoutePoints = decodedPoints
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();
    emit(MapState(
      isLoading: state.isLoading,
      currentLocation: state.currentLocation,
      destination: _destination,
      routePoints: newRoutePoints,
    ));
  }

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) return false;
    }
    return true;
  }

  LatLng? get motorcyclePosition {
    if (state.routePoints.isEmpty) return null;
    return state.routePoints[min(5, state.routePoints.length - 1)];
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    controller.dispose();
    return super.close();
  }
}