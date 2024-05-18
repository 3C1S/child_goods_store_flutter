// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'together_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TogetherModelImpl _$$TogetherModelImplFromJson(Map<String, dynamic> json) =>
    _$TogetherModelImpl(
      togetherId: (json['togetherId'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : UserProfileModel.fromJson(json['user'] as Map<String, dynamic>),
      togetherName: json['togetherName'] as String?,
      details: json['details'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
      purchasePrice: (json['purchasePrice'] as num?)?.toInt(),
      mainCategory: EMainCategory.fromJson(json['mainCategory'] as String?),
      subCategory: ESubCategory.fromJson(json['subCategory'] as String?),
      state: EProductSaleState.fromJson(json['state'] as String?),
      age: EChildAge.fromJson(json['age'] as String?),
      link: json['link'] as String?,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      address: json['address'] as String?,
      detailAddress: json['detailAddress'] as String?,
      totalNum: (json['totalNum'] as num?)?.toInt(),
      purchaseNum: (json['purchaseNum'] as num?)?.toInt(),
      tag: (json['tag'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      togetherImage: (json['togetherImage'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      togetherHeart: json['togetherHeart'] as bool?,
    );

Map<String, dynamic> _$$TogetherModelImplToJson(_$TogetherModelImpl instance) =>
    <String, dynamic>{
      'togetherId': instance.togetherId,
      'user': instance.user?.toJson(),
      'togetherName': instance.togetherName,
      'details': instance.details,
      'totalPrice': instance.totalPrice,
      'purchasePrice': instance.purchasePrice,
      'mainCategory': EMainCategory.toJson(instance.mainCategory),
      'subCategory': ESubCategory.toJson(instance.subCategory),
      'state': EProductSaleState.toJson(instance.state),
      'age': EChildAge.toJson(instance.age),
      'link': instance.link,
      'deadline': instance.deadline?.toIso8601String(),
      'address': instance.address,
      'detailAddress': instance.detailAddress,
      'totalNum': instance.totalNum,
      'purchaseNum': instance.purchaseNum,
      'tag': instance.tag,
      'togetherImage': instance.togetherImage,
      'togetherHeart': instance.togetherHeart,
    };
