import 'package:child_goods_store_flutter/models/product/product_preview_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/purchase/purchase_model.dart';
import 'package:child_goods_store_flutter/models/together/together_preview_model.dart';

abstract interface class IProfileRepository {
  ///
  /// API 103
  Future<ResModel<List<ProductPreviewModel>>> getProfileProductList({
    required int userId,
    required int page,
  });

  ///
  /// API 104
  Future<ResModel<List<ProductPreviewModel>>> getProfileProductHeartList({
    required int page,
  });

  ///
  /// API 105
  Future<ResModel<List<PurchaseModel>>> getProfileProductPurchaseList({
    required int page,
  });

  ///
  /// API 202
  Future<ResModel<List<TogetherPreviewModel>>> getProfileTogetherList({
    required int userId,
    required int page,
  });

  ///
  /// API 203
  Future<ResModel<List<TogetherPreviewModel>>> getProfileTogetherHeartList({
    required int page,
  });

  ///
  /// API 204
  Future<ResModel<List<PurchaseModel>>> getProfileTogetherPurchaseList({
    required int page,
  });
}
