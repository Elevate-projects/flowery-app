import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'resend_code_request_dto.g.dart';

@JsonSerializable()
class ResendCodeRequestDto extends Equatable {
  @JsonKey(name: "email")
  final String? email;

  const ResendCodeRequestDto({this.email});

  factory ResendCodeRequestDto.fromJson(Map<String, dynamic> json) {
    return _$ResendCodeRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResendCodeRequestDtoToJson(this);
  }


  @override
  List<Object?> get props => [email];
}
