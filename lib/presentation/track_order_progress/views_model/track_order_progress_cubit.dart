import 'dart:async';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/cache/shared_preferences_helper.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';
import 'package:flowery_app/domain/use_cases/get_tracked_order/get_tracked_order_use_case.dart';
import 'package:flowery_app/domain/use_cases/order_received/order_received_use_case.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_intent.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class TrackOrderProgressCubit extends Cubit<TrackOrderProgressState> {
  final GetTrackedOrderUseCase _getTrackedOrderUseCase;
  final OrderReceivedUseCase _orderReceivedUseCase;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  TrackOrderProgressCubit(
    this._getTrackedOrderUseCase,
    this._orderReceivedUseCase,
    this._sharedPreferencesHelper,
  ) : super(const TrackOrderProgressState());

  late final bool isArLanguage;
  StreamSubscription<Result<OrderEntity?>>? _orderSubscription;

  Future<void> doIntent({required TrackOrderProgressIntent intent}) async {
    switch (intent) {
      case FetchTrackedOrderDataIntent():
        _fetchTrackedOrder(orderId: intent.orderId);
        break;
      case OpenWhatsAppIntent():
        await _openWhatsApp();
        break;
      case OpenPhoneIntent():
        await _openPhoneDialer();
        break;
      case OrderReceivedIntent():
        await _receivedOrder();
        break;
      case ShowMapIntent():
        _showMap();
        break;
    }
  }

  void _fetchTrackedOrder({required String orderId}) {
    emit(state.copyWith(currentOrderStatus: const StateStatus.loading()));
    isArLanguage = _sharedPreferencesHelper.getBool(
      key: ConstKeys.isArLanguage,
    );
    _orderSubscription = _getTrackedOrderUseCase.invoke(orderId: orderId).listen((
      orderData,
    ) {
      switch (orderData) {
        case Success<OrderEntity?>():
          {
            if (orderData.data != null) {
              // 1. Get the previous location from the *current* state
              final previousOrderData = state.currentOrderStatus.data;
              double newBearing =
                  state.bearing; // Default to the last known bearing
              // 2. Check if we have a previous location and if the location has changed
              if (previousOrderData != null &&
                  (previousOrderData.driverLatitude !=
                          orderData.data!.driverLatitude ||
                      previousOrderData.driverLongitude !=
                          orderData.data!.driverLongitude) &&
                  state.currentOrderStateIndex >= 2) {
                final prevPoint = LatLng(
                  double.parse(previousOrderData.driverLatitude.toString()),
                  double.parse(previousOrderData.driverLongitude.toString()),
                );

                final newPoint = LatLng(
                  double.parse(orderData.data!.driverLatitude.toString()),
                  double.parse(orderData.data!.driverLongitude.toString()),
                );

                // 3. Calculate the new bearing in degrees
                newBearing = const latlong.Distance().bearing(
                  prevPoint,
                  newPoint,
                );
              }
              final orderState = _getCurrentOrderState(
                orderData: orderData.data,
              );
              final orderProgressDates = _loadOrderDates(
                orderData: orderData.data,
              );
              emit(
                state.copyWith(
                  currentOrderStatus: StateStatus.success(orderData.data),
                  currentOrderStateIndex: orderState,
                  orderProgressDates: orderProgressDates,
                  bearing: newBearing,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  currentOrderStatus: const StateStatus.success(null),
                ),
              );
            }
          }
          break;
        case Failure<OrderEntity?>():
          emit(
            state.copyWith(
              currentOrderStatus: StateStatus.failure(
                orderData.responseException,
              ),
            ),
          );
          emit(state.copyWith(currentOrderStatus: const StateStatus.initial()));
          break;
      }
    });
  }

  Future<void> _receivedOrder() async {
    emit(state.copyWith(receivedOrderStatus: const StateStatus.loading()));
    final result = await _orderReceivedUseCase.invoke(
      orderId: state.currentOrderStatus.data?.id ?? "",
    );
    if (isClosed) return;
    switch (result) {
      case Success<void>():
        emit(
          state.copyWith(receivedOrderStatus: const StateStatus.success(null)),
        );
        break;
      case Failure<void>():
        emit(
          state.copyWith(
            receivedOrderStatus: StateStatus.failure(result.responseException),
          ),
        );
        emit(state.copyWith(receivedOrderStatus: const StateStatus.initial()));
        break;
    }
  }

  List<String> _loadOrderDates({required OrderEntity? orderData}) {
    if (orderData != null) {
      return [
        (orderData.orderAcceptedAt?.isNotEmpty ?? false)
            ? _progressDateFormatter(orderData.orderAcceptedAt)!
            : "",
        (orderData.preparingYourOrderAt?.isNotEmpty ?? false)
            ? _progressDateFormatter(orderData.preparingYourOrderAt)!
            : "",
        (orderData.outForDeliveryAt?.isNotEmpty ?? false)
            ? _progressDateFormatter(orderData.outForDeliveryAt)!
            : "",
        (orderData.deliveredAt?.isNotEmpty ?? false)
            ? _progressDateFormatter(orderData.deliveredAt)!
            : "",
      ];
    }
    return ["", "", "", ""];
  }

  String? _progressDateFormatter(String? date) {
    if (date?.trim().isNotEmpty ?? false) {
      final dateTime = DateTime.parse(date!);
      final formattedDate = DateFormat(
        'dd MMM yyyy - h:mm a',
        isArLanguage ? "ar" : "en",
      ).format(dateTime);
      return formattedDate;
    }
    return date;
  }

  int _getCurrentOrderState({required OrderEntity? orderData}) {
    if (orderData?.state == ConstKeys.inProgress) {
      return 0;
    } else if (orderData?.state == ConstKeys.arrivedAtPickupPoint) {
      return 1;
    } else if (orderData?.state == ConstKeys.startDeliver ||
        orderData?.state == ConstKeys.arrivedToTheUser) {
      return 2;
    } else if (orderData?.state == ConstKeys.deliveredToTheUser) {
      return 3;
    } else {
      return 3;
    }
  }

  Future<void> _openWhatsApp() async {
    final whatsappUri = Uri.parse(
      'whatsapp://send?phone=${state.currentOrderStatus.data?.driverPhone}${''}',
    );
    final waMeUri = Uri.parse(
      'https://wa.me/${state.currentOrderStatus.data?.driverPhone}${''}',
    );

    try {
      emit(
        state.copyWith(
          openWhatsappStatus: const StateStatus.loading(),
          isOpeningWhatsapp: true,
        ),
      );
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
        emit(
          state.copyWith(
            openWhatsappStatus: const StateStatus.success(null),
            isOpeningWhatsapp: false,
          ),
        );
        return;
      }

      if (await canLaunchUrl(waMeUri)) {
        await launchUrl(waMeUri, mode: LaunchMode.externalApplication);
        emit(
          state.copyWith(
            openWhatsappStatus: const StateStatus.success(null),
            isOpeningWhatsapp: false,
          ),
        );
        return;
      }
    } catch (e) {
      emit(
        state.copyWith(
          openWhatsappStatus: const StateStatus.failure(
            ResponseException(message: AppText.openWhatsappFailureMessage),
          ),
        ),
      );
      emit(
        state.copyWith(
          openWhatsappStatus: const StateStatus.initial(),
          isOpeningWhatsapp: false,
          selectedPhoneNumber: "",
        ),
      );
    }
  }

  Future<void> _openPhoneDialer() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: state.currentOrderStatus.data?.driverPhone,
    );

    try {
      emit(
        state.copyWith(
          openPhoneStatus: const StateStatus.loading(),
          isOpeningPhone: true,
        ),
      );
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
        emit(
          state.copyWith(
            openPhoneStatus: const StateStatus.success(null),
            isOpeningPhone: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          openPhoneStatus: const StateStatus.failure(
            ResponseException(message: AppText.openPhoneFailureMessage),
          ),
        ),
      );
      emit(
        state.copyWith(
          openPhoneStatus: const StateStatus.initial(),
          isOpeningPhone: false,
        ),
      );
    }
  }

  void _showMap() {
    if (state.currentOrderStatus.data?.driverLatitude != null &&
        state.currentOrderStatus.data?.driverLongitude != null) {
      emit(state.copyWith(isShowMap: !state.isShowMap));
    }
  }

  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}
