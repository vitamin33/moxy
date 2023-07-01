import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String userId;
  String accessToken;
  String refreshToken;
  String userRole;

  LoginResponse(
      this.accessToken, this.refreshToken, this.userId, this.userRole);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
