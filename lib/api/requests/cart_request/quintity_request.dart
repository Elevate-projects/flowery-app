import 'package:json_annotation/json_annotation.dart';

part 'quintity_request.g.dart';

@JsonSerializable()
class QuantityRequest {
  @JsonKey(name: "quantity")
  final int? quantity;

  QuantityRequest ({
    this.quantity,
  });

  factory QuantityRequest.fromJson(Map<String, dynamic> json) {
    return _$QuantityRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuantityRequestToJson(this);
  }
}


