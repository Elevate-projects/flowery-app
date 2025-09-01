import 'dart:convert';

import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/constants/json_screens.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/presentation/about_us/views_model/about_us_intent.dart';
import 'package:flowery_app/presentation/about_us/views_model/about_us_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(const AboutUsState());

  Future<void> doIntent({required AboutUsIntent intent}) async {
    switch (intent) {
      case AboutUsInitializationIntent():
        await _onInit();
    }
  }

  Future<void> _onInit() async {
    await _loadAboutUsScreenData();
  }

  Future<void> _loadAboutUsScreenData() async {
    try {
      emit(state.copyWith(aboutUsSectionsStatus: const StateStatus.loading()));
      final jsonString = await rootBundle.loadString(JsonScreens.aboutUs);
      if (isClosed) return;
      final data = json.decode(jsonString);
      emit(
        state.copyWith(
          aboutUsSectionsStatus: StateStatus.success(data['about_app']),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          aboutUsSectionsStatus: StateStatus.failure(
            ResponseException(
              message: "${AppText.unexpectedError} ${error.toString()}",
            ),
          ),
        ),
      );
    }
  }
}
