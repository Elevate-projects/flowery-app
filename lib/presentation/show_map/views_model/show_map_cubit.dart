import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flowery_app/presentation/show_map/views_model/show_map_intent.dart';
import 'package:flowery_app/presentation/show_map/views_model/show_map_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class ShowMapCubit extends Cubit<ShowMapState> {
  final MapController mapController = MapController();

  ShowMapCubit() : super(const ShowMapState());

  Future<void> doIntent(ShowMapIntent intent) {
    switch (intent) {
      case ShowMapInitializationIntent():
        return _initMap(
          userLocation: intent.userLocation,
          storeLocation: intent.storeLocation,
        );
    }
  }

  Future<void> _initMap({
    required LatLng userLocation,
    required LatLng storeLocation,
  }) async {
    emit(
      state.copyWith(userLocation: userLocation, storeLocation: storeLocation),
    );
    await _updatePolyline(userLocation, storeLocation);
  }

  /// 🛣️ Draw route between driver and user
  Future<void> _updatePolyline(LatLng start, LatLng end) async {
    try {
      final url = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/'
        '${start.longitude},${start.latitude};'
        '${end.longitude},${end.latitude}?overview=full&geometries=geojson',
      );

      final res = await http.get(url);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final coords = (data['routes']?[0]['geometry']['coordinates'] ?? [])
            .map<LatLng>((c) => LatLng(c[1], c[0]))
            .toList();

        emit(state.copyWith(polylinePoints: coords));
      }
    } catch (e) {
      log('🚨 Route error: $e');
    }
  }
}
