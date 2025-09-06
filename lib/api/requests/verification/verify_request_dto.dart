import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'verify_request_dto.g.dart';

@JsonSerializable()
class VerifyRequestDto extends Equatable {
  @JsonKey(name: "resetCode")
  final String? resetCode;

  const VerifyRequestDto({this.resetCode});

  factory VerifyRequestDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyRequestDtoToJson(this);

  @override
  List<Object?> get props => [resetCode];
}
