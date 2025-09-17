import 'package:flowery_app/presentation/checkout/views_model/checkout_cubit/gift_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:injectable/injectable.dart';

@injectable
class GiftSwitchCubit extends Cubit<GiftSwitchState> {
  GiftSwitchCubit() : super(GiftSwitchInitial());

  void toggleGiftSwitch(bool value) {
    emit(GiftSwitchInitial(isGift: value));
  }
}
