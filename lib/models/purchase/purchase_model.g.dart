// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseModelImpl _$$PurchaseModelImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseModelImpl(
      category: EChatItemType.fromJson(json['category'] as String?),
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      sellerName: json['sellerName'] as String?,
      price: (json['price'] as num?)?.toInt(),
      saleCompleteDate: json['saleCompleteDate'] == null
          ? null
          : DateTime.parse(json['saleCompleteDate'] as String),
      image: json['image'] as String?,
      isReview: json['isReview'] as bool?,
    );

Map<String, dynamic> _$$PurchaseModelImplToJson(_$PurchaseModelImpl instance) =>
    <String, dynamic>{
      'category': EChatItemType.toJson(instance.category),
      'id': instance.id,
      'title': instance.title,
      'sellerName': instance.sellerName,
      'price': instance.price,
      'saleCompleteDate': instance.saleCompleteDate?.toIso8601String(),
      'image': instance.image,
      'isReview': instance.isReview,
    };
