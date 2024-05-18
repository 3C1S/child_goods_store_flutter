// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressModelImpl _$$AddressModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressModelImpl(
      addressId: (json['addressId'] as num?)?.toInt(),
      address: json['address'] as String?,
      detailAddress: json['detailAddress'] as String?,
      category: EAddressCategory.fromJson(json['category'] as String?),
    );

Map<String, dynamic> _$$AddressModelImplToJson(_$AddressModelImpl instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'address': instance.address,
      'detailAddress': instance.detailAddress,
      'category': EAddressCategory.toJson(instance.category),
    };
