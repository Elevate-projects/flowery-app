import 'package:flutter_bloc/flutter_bloc.dart';

class AddressCubit extends Cubit<int?> {
  AddressCubit() : super(null);
  void selectAddress(int index) => emit(index);
}
