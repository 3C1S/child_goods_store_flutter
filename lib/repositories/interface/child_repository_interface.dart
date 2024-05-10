import 'package:child_goods_store_flutter/models/child/child_model.dart';
import 'package:child_goods_store_flutter/models/product/product_preview_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';

abstract interface class IChildRepository {
  ///
  /// API 11
  Future<ResModel<List<ChildModel>>> getChild();

  ///
  /// API 12
  Future<ResModel<ChildModel>> postChild({
    required ChildModel child,
  });

  ///
  /// API 13
  Future<ResModel<ChildModel>> patchChild({
    required ChildModel child,
  });

  /// API 102
  Future<ResModel<List<ProductPreviewModel>>> getChildProductList({
    required int childId,
    required int page,
  });
}
