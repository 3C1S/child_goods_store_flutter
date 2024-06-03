import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room_model.freezed.dart';
part 'chat_room_model.g.dart';

@freezed
class ChatRoomModel with _$ChatRoomModel {
  factory ChatRoomModel({
    int? chatRoomId,
    @JsonKey(
      fromJson: EChatItemType.fromJson,
      toJson: EChatItemType.toJson,
    )
    EChatItemType? category,
    int? id,
    String? productName,
    String? productImage,
    int? participantsNum,
    int? price,
    int? unitPrice,
    DateTime? endDate,
    String? message,
    DateTime? createdAt,
  }) = _ChatRoomModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
}
