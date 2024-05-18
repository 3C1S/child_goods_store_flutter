// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewModelImpl _$$ReviewModelImplFromJson(Map<String, dynamic> json) =>
    _$ReviewModelImpl(
      reviewId: (json['reviewId'] as num?)?.toInt(),
      type: EChatItemType.fromJson(json['type'] as String?),
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      userImage: json['userImage'] as String?,
      userName: json['userName'] as String?,
      averageStars: (json['averageStars'] as num?)?.toDouble(),
      totalReview: (json['totalReview'] as num?)?.toInt(),
      score: (json['score'] as num?)?.toInt(),
      content: json['content'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$ReviewModelImplToJson(_$ReviewModelImpl instance) =>
    <String, dynamic>{
      'reviewId': instance.reviewId,
      'type': EChatItemType.toJson(instance.type),
      'id': instance.id,
      'userId': instance.userId,
      'userImage': instance.userImage,
      'userName': instance.userName,
      'averageStars': instance.averageStars,
      'totalReview': instance.totalReview,
      'score': instance.score,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'name': instance.name,
    };
