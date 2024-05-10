// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as int?,
      nickName: json['nickName'] as String?,
      introduce: json['introduce'] as String?,
      profileImg: json['profileImg'] as String?,
      region: json['region'] as String?,
      town: json['town'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickName': instance.nickName,
      'introduce': instance.introduce,
      'profileImg': instance.profileImg,
      'region': instance.region,
      'town': instance.town,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
