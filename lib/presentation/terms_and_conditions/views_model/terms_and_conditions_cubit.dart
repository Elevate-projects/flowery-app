import 'dart:convert';

import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/constants/json_screens.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/presentation/terms_and_conditions/views_model/terms_and_conditions_intent.dart';
import 'package:flowery_app/presentation/terms_and_conditions/views_model/terms_and_conditions_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TermsAndConditionsCubit extends Cubit<TermsAndConditionsState> {
  TermsAndConditionsCubit() : super(const TermsAndConditionsState());

  Future<void> doIntent({required TermsAndConditionsIntent intent}) async {
    switch (intent) {
      case TermsAndConditionsInitializationIntent():
        await _onInit();
    }
  }

  Future<void> _onInit() async {
    await _loadTermsAndConditionsScreenData();
  }

  Future<void> _loadTermsAndConditionsScreenData() async {
    try {
      emit(
        state.copyWith(termsAndConditionsStatus: const StateStatus.loading()),
      );
      final jsonString = await rootBundle.loadString(
        JsonScreens.termsAndConditions,
      );
      if (isClosed) return;
      final data = json.decode(jsonString);
      emit(
        state.copyWith(
          termsAndConditionsStatus: StateStatus.success(
            data['terms_and_conditions'],
          ),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          termsAndConditionsStatus: StateStatus.failure(
            ResponseException(
              message: "${AppText.unexpectedError} ${error.toString()}",
            ),
          ),
        ),
      );
    }
  }
}
