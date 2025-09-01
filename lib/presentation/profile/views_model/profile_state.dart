import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';

class ProfileState extends Equatable {
  final StateStatus<void> profileStatus;
  const ProfileState({this.profileStatus = const StateStatus.initial()});

  ProfileState copyWith({StateStatus<void>? profileStatus}) {
    return ProfileState(profileStatus: profileStatus ?? this.profileStatus);
  }

  @override
  List<Object?> get props => [profileStatus];
}
