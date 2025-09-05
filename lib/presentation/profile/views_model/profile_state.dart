import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_cubit.dart';

class ProfileState extends Equatable {
  final StateStatus<void> profileStatus;
  final Languages selectedLanguage;
  const ProfileState({
    this.profileStatus = const StateStatus.initial(),
    this.selectedLanguage = Languages.english,
  });

  ProfileState copyWith({
    StateStatus<void>? profileStatus,
    Languages? selectedLanguage,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

  @override
  List<Object?> get props => [profileStatus, selectedLanguage];
}
