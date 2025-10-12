import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';

final class TrackOrderProgressState extends Equatable {
  final StateStatus<OrderEntity?> currentOrderStatus;
  final StateStatus<void> receivedOrderStatus;
  final StateStatus<void> openWhatsappStatus;
  final StateStatus<void> openPhoneStatus;
  final int currentOrderStateIndex;
  final bool isOpeningWhatsapp;
  final bool isOpeningPhone;
  final List<String> orderStates = const [
    AppText.receivedYourOrder,
    AppText.preparingYourOrder,
    AppText.outForDelivery,
    AppText.delivered,
  ];
  final List<String> orderProgressDates;
  const TrackOrderProgressState({
    this.currentOrderStatus = const StateStatus.initial(),
    this.receivedOrderStatus = const StateStatus.initial(),
    this.openWhatsappStatus = const StateStatus.initial(),
    this.openPhoneStatus = const StateStatus.initial(),
    this.currentOrderStateIndex = 0,
    this.orderProgressDates = const ["", "", "", ""],
    this.isOpeningWhatsapp = false,
    this.isOpeningPhone = false,
  });
  TrackOrderProgressState copyWith({
    StateStatus<OrderEntity>? currentOrderStatus,
    StateStatus<void>? receivedOrderStatus,
    StateStatus<void>? openWhatsappStatus,
    StateStatus<void>? openPhoneStatus,
    List<String>? orderProgressDates,
    int? currentOrderStateIndex,
    String? selectedPhoneNumber,
    bool? isOpeningWhatsapp,
    bool? isOpeningPhone,
  }) {
    return TrackOrderProgressState(
      currentOrderStatus: currentOrderStatus ?? this.currentOrderStatus,
      receivedOrderStatus: receivedOrderStatus ?? this.receivedOrderStatus,
      openWhatsappStatus: openWhatsappStatus ?? this.openWhatsappStatus,
      openPhoneStatus: openPhoneStatus ?? this.openPhoneStatus,
      orderProgressDates: orderProgressDates ?? this.orderProgressDates,
      currentOrderStateIndex:
          currentOrderStateIndex ?? this.currentOrderStateIndex,
      isOpeningWhatsapp: isOpeningWhatsapp ?? this.isOpeningWhatsapp,
      isOpeningPhone: isOpeningPhone ?? this.isOpeningPhone,
    );
  }

  @override
  List<Object?> get props => [
    currentOrderStatus,
    receivedOrderStatus,
    openWhatsappStatus,
    openPhoneStatus,
    currentOrderStateIndex,
    orderStates,
    orderProgressDates,
    isOpeningWhatsapp,
    isOpeningPhone,
  ];
}
