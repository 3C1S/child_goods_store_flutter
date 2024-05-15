// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomModelImpl _$$ChatRoomModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomModelImpl(
      chatRoomId: (json['chatRoomId'] as num?)?.toInt(),
      category: EChatItemType.fromJson(json['category'] as String?),
      id: (json['id'] as num?)?.toInt(),
      productName: json['productName'] as String?,
      participantsNum: (json['participantsNum'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      unitPrice: (json['unitPrice'] as num?)?.toInt(),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      message: json['message'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ChatRoomModelImplToJson(_$ChatRoomModelImpl instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'category': EChatItemType.toJson(instance.category),
      'id': instance.id,
      'productName': instance.productName,
      'participantsNum': instance.participantsNum,
      'price': instance.price,
      'unitPrice': instance.unitPrice,
      'endDate': instance.endDate?.toIso8601String(),
      'message': instance.message,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
