import 'package:child_goods_store_flutter/enums/child_age.dart';
import 'package:child_goods_store_flutter/enums/main_category.dart';
import 'package:child_goods_store_flutter/enums/product_sale_state.dart';
import 'package:child_goods_store_flutter/enums/product_state.dart';
import 'package:child_goods_store_flutter/enums/sub_category.dart';
import 'package:child_goods_store_flutter/models/user/user_profile_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  factory ProductModel({
    int? productId,
    UserProfileModel? user,
    String? productName,
    int? price,
    String? content,
    @JsonKey(
      fromJson: EMainCategory.fromJson,
      toJson: EMainCategory.toJson,
    )
    EMainCategory? mainCategory,
    @JsonKey(
      fromJson: ESubCategory.fromJson,
      toJson: ESubCategory.toJson,
    )
    ESubCategory? subCategory,
    @JsonKey(
      fromJson: EProductState.fromJson,
      toJson: EProductState.toJson,
    )
    EProductState? productState,
    @JsonKey(
      fromJson: EProductSaleState.fromJson,
      toJson: EProductSaleState.toJson,
    )
    EProductSaleState? state,
    @JsonKey(
      fromJson: EChildAge.fromJson,
      toJson: EChildAge.toJson,
    )
    EChildAge? age,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default([]) List<String> tag,
    @Default([]) List<String> productImage,
    bool? productHeart,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
