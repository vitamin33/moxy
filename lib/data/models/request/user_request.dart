import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
class NetworkUser {
  final String? firstName;
  final String? secondName;
  final String mobileNumber;
  final String? city;
  final String? instagram;

  NetworkUser({
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.city,
    required this.instagram,
  });

  factory NetworkUser.fromJson(Map<String, dynamic> json) =>
      _$NetworkUserFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkUserToJson(this);
}
