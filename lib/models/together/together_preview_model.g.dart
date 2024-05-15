// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'together_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TogetherPreviewModelImpl _$$TogetherPreviewModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TogetherPreviewModelImpl(
      togetherId: (json['togetherId'] as num?)?.toInt(),
      togetherName: json['togetherName'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
      purchasePrice: (json['purchasePrice'] as num?)?.toInt(),
      totalNum: (json['totalNum'] as num?)?.toInt(),
      purchaseNum: (json['purchaseNum'] as num?)?.toInt(),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      togetherImage: json['togetherImage'] as String?,
      togetherHeart: json['togetherHeart'] as bool?,
    );

Map<String, dynamic> _$$TogetherPreviewModelImplToJson(
        _$TogetherPreviewModelImpl instance) =>
    <String, dynamic>{
      'togetherId': instance.togetherId,
      'togetherName': instance.togetherName,
      'totalPrice': instance.totalPrice,
      'purchasePrice': instance.purchasePrice,
      'totalNum': instance.totalNum,
      'purchaseNum': instance.purchaseNum,
      'deadline': instance.deadline?.toIso8601String(),
      'togetherImage': instance.togetherImage,
      'togetherHeart': instance.togetherHeart,
    };
