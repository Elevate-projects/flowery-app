import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'best_seller_intent.dart';
import 'best_seller_state.dart';

@injectable
class BestSellerCubit extends Cubit<BestSellerState> {
  BestSellerCubit() : super(const BestSellerState());

  void doIntent(BestSellerIntent intent) {
    switch (intent) {
      case LoadBestSellerIntent():
        return _loadBestSeller();
    }
  }

  void _loadBestSeller() async {
    emit(state.copyWith(status: Status.success));
  }
}
