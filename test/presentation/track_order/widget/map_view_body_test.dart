import 'package:flowery_app/presentation/track_order/view_model/map_cubit.dart';
import 'package:flowery_app/presentation/track_order/view_model/map_state.dart';
import 'package:flowery_app/presentation/track_order/widget/map_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';

class MockMapCubit extends Mock implements MapCubit {}

void main() {
  late MockMapCubit mockMapCubit;

  setUp(() {
    mockMapCubit = MockMapCubit();
    when(() => mockMapCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createTestWidget(MapState state) {
    when(() => mockMapCubit.state).thenReturn(state);
    when(() => mockMapCubit.controller).thenReturn(MapCubit().controller);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<MapCubit>.value(
            value: mockMapCubit,
            child: const Scaffold(
              body: MapViewBody(),
            ),
          ),
        );
      },
    );
  }

  testWidgets('Show the map when the state is initial', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(MapState.initial()));

    expect(find.byType(MapViewBody), findsOneWidget);
    expect(find.byType(FlutterMap), findsOneWidget);
  });

  testWidgets(' when find polyline when route points are available', (WidgetTester tester) async {
    final routePoints = [
      const LatLng(30.0444, 31.2357),
      const LatLng(30.0500, 31.2400),
    ];

    await tester.pumpWidget(createTestWidget(MapState(
      isLoading: false,
      currentLocation: const LatLng(30.0444, 31.2357),
      destination: const LatLng(30.0500, 31.2400),
      routePoints: routePoints,
    )));
    expect(find.byType(PolylineLayer), findsOneWidget);
  });

  testWidgets('Show the current location marker when the state is not initial ', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(const MapState(
      isLoading: false,
      currentLocation: LatLng(30.0444, 31.2357),
      destination: LatLng(30.0500, 31.2400),
      routePoints: [],
    )));

    expect(find.byIcon(Icons.location_on_outlined), findsWidgets);
  });
}
