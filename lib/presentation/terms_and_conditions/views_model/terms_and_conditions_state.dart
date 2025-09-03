import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';

class TermsAndConditionsState extends Equatable {
  final StateStatus<List<dynamic>> termsAndConditionsStatus;
  const TermsAndConditionsState({
    this.termsAndConditionsStatus = const StateStatus.initial(),
  });

  TermsAndConditionsState copyWith({
    StateStatus<List<dynamic>>? termsAndConditionsStatus,
  }) {
    return TermsAndConditionsState(
      termsAndConditionsStatus:
          termsAndConditionsStatus ?? this.termsAndConditionsStatus,
    );
  }

  @override
  List<Object?> get props => [termsAndConditionsStatus];
}
