// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileModelImpl _$$UserProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserProfileModelImpl(
      userId: (json['userId'] as num?)?.toInt(),
      nickName: json['nickName'] as String?,
      introduce: json['introduce'] as String?,
      profileImg: json['profileImg'] as String?,
      followNum: (json['followNum'] as num?)?.toInt(),
      followingNum: (json['followingNum'] as num?)?.toInt(),
      isFollowed: json['isFollowed'] as bool?,
      averageStars: (json['averageStars'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserProfileModelImplToJson(
        _$UserProfileModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickName': instance.nickName,
      'introduce': instance.introduce,
      'profileImg': instance.profileImg,
      'followNum': instance.followNum,
      'followingNum': instance.followingNum,
      'isFollowed': instance.isFollowed,
      'averageStars': instance.averageStars,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
