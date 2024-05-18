// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatModelImpl _$$ChatModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatModelImpl(
      user: json['user'] == null
          ? null
          : UserProfileModel.fromJson(json['user'] as Map<String, dynamic>),
      message: json['message'] as String?,
      isLeader: json['isLeader'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ChatModelImplToJson(_$ChatModelImpl instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'message': instance.message,
      'isLeader': instance.isLeader,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
