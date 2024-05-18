// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductPreviewModelImpl _$$ProductPreviewModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductPreviewModelImpl(
      productId: (json['productId'] as num?)?.toInt(),
      productName: json['productName'] as String?,
      price: (json['price'] as num?)?.toInt(),
      state: EProductSaleState.fromJson(json['state'] as String?),
      productImage: json['productImage'] as String?,
      productHeart: json['productHeart'] as bool?,
    );

Map<String, dynamic> _$$ProductPreviewModelImplToJson(
        _$ProductPreviewModelImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'price': instance.price,
      'state': EProductSaleState.toJson(instance.state),
      'productImage': instance.productImage,
      'productHeart': instance.productHeart,
    };
