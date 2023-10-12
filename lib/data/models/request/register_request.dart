import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class NetworkRegister {
  final String firstName;
  final String secondName;
  final String mobileNumber;
  final String email;
  final String password;

  NetworkRegister({
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.email,
    required this.password,
  });

  factory NetworkRegister.fromJson(Map<String, dynamic> json) =>
      _$NetworkRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkRegisterToJson(this);
}


@JsonSerializable()
class NetworkConfirmationCode {
  final String email;
  final String confirmationCode;

  NetworkConfirmationCode({
    required this.email,
    required this.confirmationCode,
  });

  factory NetworkConfirmationCode.fromJson(Map<String, dynamic> json) =>
      _$NetworkConfirmationCodeFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkConfirmationCodeToJson(this);
}



