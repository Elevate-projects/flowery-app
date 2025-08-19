import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/resend_code/request/resend_code_request.dart';

part 'resend_code_request_dto.g.dart';

@JsonSerializable()
class ResendCodeRequestDto extends Equatable {
  @JsonKey(name: "email")
  final String? email;

  ResendCodeRequestDto({this.email});

  factory ResendCodeRequestDto.fromJson(Map<String, dynamic> json) {
    return _$ResendCodeRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResendCodeRequestDtoToJson(this);
  }

  static ResendCodeRequestDto toDto(ResendCodeRequestEntity entity) {
    return ResendCodeRequestDto(email: entity.email);
  }

  @override
  List<Object?> get props => [email];
}
