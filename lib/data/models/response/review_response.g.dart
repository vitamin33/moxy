// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllReviewResponse _$AllReviewResponseFromJson(Map<String, dynamic> json) =>
    AllReviewResponse(
      (json['allReview'] as List<dynamic>?)
          ?.map((e) => NetworkReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllReviewResponseToJson(AllReviewResponse instance) =>
    <String, dynamic>{
      'allReview': instance.allReview,
    };

NetworkReview _$NetworkReviewFromJson(Map<String, dynamic> json) =>
    NetworkReview(
      id: json['_id'] as String?,
      clientName: json['clientName'] as String,
      reviewText: json['reviewText'] as String,
      rating: json['rating'] as int,
      productId: json['productId'] as String,
      avatarImageUrl: json['avatarImageUrl'] as String,
    );

Map<String, dynamic> _$NetworkReviewToJson(NetworkReview instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'clientName': instance.clientName,
      'reviewText': instance.reviewText,
      'rating': instance.rating,
      'productId': instance.productId,
      'avatarImageUrl': instance.avatarImageUrl,
    };
