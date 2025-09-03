import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';

class AboutUsState extends Equatable {
  final StateStatus<List<dynamic>> aboutUsSectionsStatus;
  const AboutUsState({
    this.aboutUsSectionsStatus = const StateStatus.initial(),
  });

  AboutUsState copyWith({StateStatus<List<dynamic>>? aboutUsSectionsStatus}) {
    return AboutUsState(
      aboutUsSectionsStatus:
          aboutUsSectionsStatus ?? this.aboutUsSectionsStatus,
    );
  }

  @override
  List<Object?> get props => [aboutUsSectionsStatus];
}
