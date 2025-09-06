import 'package:equatable/equatable.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';

class EditProfileState extends Equatable{
  final StateStatus<Result<UserDataEntity>?> editProfileState;

  const EditProfileState({this.editProfileState = const StateStatus.initial()});

  @override
  List<Object?> get props => [editProfileState];

  EditProfileState copyWith({StateStatus<Result<UserDataEntity>?>? editProfileState}) {
    return EditProfileState(
      editProfileState: editProfileState ?? this.editProfileState
    );
  }
}