import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<String> {
  PaymentCubit() : super("");

  void selectMethod(String method) => emit(method);
}
