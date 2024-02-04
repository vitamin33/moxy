import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscribe_request.g.dart';

@JsonSerializable()
class SubscribeRequest {
  final String email;
  final String firstName;

  SubscribeRequest({required this.email, required this.firstName});

  factory SubscribeRequest.fromJson(Map<String, dynamic> json) =>
      _$SubscribeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubscribeRequestToJson(this);
}
