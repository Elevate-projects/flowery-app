import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';

enum Status { initial, loading, success, error }

class BestSellerState extends Equatable {
  final Status status;
  final ResponseException? exception;

  const BestSellerState({this.status = Status.initial, this.exception});

  BestSellerState copyWith({Status? status, ResponseException? exception}) {
    return BestSellerState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [status, exception];
}
