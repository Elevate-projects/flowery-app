import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/resend_code/response/resend_code_response.dart';

part 'resend_code_response_dto.g.dart';

@JsonSerializable()
class ResendCodeResponseDto extends Equatable {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "info")
  final String? info;

  ResendCodeResponseDto({this.message, this.info});

  factory ResendCodeResponseDto.fromJson(Map<String, dynamic> json) {
    return _$ResendCodeResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResendCodeResponseDtoToJson(this);
  }

  static ResendCodeResponseEntity toEntity(ResendCodeResponseDto dto) {
    return ResendCodeResponseEntity(message: dto.message, info: dto.info);
  }

  @override
  List<Object?> get props => [message, info];
}
