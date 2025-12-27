import 'dart:async';
import 'dart:convert';

import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';
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

  Future<void> doIntent(ShowMapIntent intent) async {
    switch (intent) {
      case ShowMapInitializationIntent():
        await _initMap(orderData: intent.orderData);
        break;
      case UpdateRouteIntent():
        await _updatePolyline(state.userLocation!, intent.driverLocation);
        break;
    }
  }

  Future<void> _initMap({required OrderEntity orderData}) async {
    final LatLng userLocation = LatLng(
      double.parse(orderData.shippingAddress!.lat.toString()),
      double.parse(orderData.shippingAddress!.long.toString()),
    );
    final LatLng driverLocation = LatLng(
      double.parse(orderData.driverLatitude!.toString()),
      double.parse(orderData.driverLongitude!.toString()),
    );
    emit(
      state.copyWith(
        mapStatus: const StateStatus.loading(),
        userLocation: userLocation,
        driverLocation: driverLocation,
      ),
    );
    await _updatePolyline(userLocation, driverLocation);
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

        emit(
          state.copyWith(
            polylinePoints: coords,
            mapStatus: const StateStatus.success(null),
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          mapStatus: StateStatus.failure(
            ResponseException(message: "Route error: $error"),
          ),
        ),
      );
      emit(state.copyWith(mapStatus: const StateStatus.initial()));
    }
  }
}
