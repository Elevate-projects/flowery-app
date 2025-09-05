import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';

class ProfileState extends Equatable {
  final StateStatus<void> profileStatus;
  final StateStatus<void> logoutStatus;
  final Languages selectedLanguage;
  const ProfileState({
    this.profileStatus = const StateStatus.initial(),
    this.logoutStatus = const StateStatus.initial(),
    this.selectedLanguage = Languages.english,
  });

  ProfileState copyWith({
    StateStatus<void>? profileStatus,
    StateStatus<void>? logoutStatus,
    Languages? selectedLanguage,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

  @override
  List<Object?> get props => [profileStatus, logoutStatus,selectedLanguage];
}
