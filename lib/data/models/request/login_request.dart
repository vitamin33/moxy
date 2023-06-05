import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final String mobileNumber;
  final String password;

  LoginRequest({required this.mobileNumber, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
