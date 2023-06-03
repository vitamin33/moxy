import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
class NetworkGuestUser {
  final String firstName;
  final String secondName;
  final String mobileNumber;
  final String city;
  final String instagram;

  NetworkGuestUser({
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.city,
    required this.instagram,
  });

  factory NetworkGuestUser.fromJson(Map<String, dynamic> json) =>
      _$NetworkGuestUserFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkGuestUserToJson(this);
}
