import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_model.freezed.dart';
part 'purchase_model.g.dart';

@freezed
class PurchaseModel with _$PurchaseModel {
  factory PurchaseModel({
    @JsonKey(
      fromJson: EChatItemType.fromJson,
      toJson: EChatItemType.toJson,
    )
    EChatItemType? category,
    int? id,
    String? title,
    String? sellerName,
    int? price,
    DateTime? saleCompleteDate,
    String? image,
    bool? isReview,
  }) = _PurchaseModel;

  factory PurchaseModel.fromJson(Map<String, dynamic> json) =>
      _$PurchaseModelFromJson(json);
}
