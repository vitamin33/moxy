import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  int statusCode;
  String message;

  ErrorResponse({
    required this.statusCode,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
