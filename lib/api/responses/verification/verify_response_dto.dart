import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/verification/response/verify_response.dart';

part 'verify_response_dto.g.dart';

@JsonSerializable()
class VerifyResponseDto extends Equatable {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "code")
  final int? code;

  VerifyResponseDto({this.status, this.message, this.code});

  factory VerifyResponseDto.fromJson(Map<String, dynamic> json) {
    return _$VerifyResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerifyResponseDtoToJson(this);
  }



  @override
  List<Object?> get props => [status, message, code];
}
