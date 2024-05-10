import 'package:child_goods_store_flutter/enums/child_age.dart';
import 'package:child_goods_store_flutter/enums/main_category.dart';
import 'package:child_goods_store_flutter/enums/product_sale_state.dart';
import 'package:child_goods_store_flutter/enums/search_range.dart';
import 'package:child_goods_store_flutter/enums/sub_category.dart';
import 'package:child_goods_store_flutter/models/product/product_model.dart';
import 'package:child_goods_store_flutter/models/product/product_preview_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/user/user_profile_model.dart';

abstract interface class IProductRepository {
  ///
  /// API 101
  Future<ResModel<List<ProductPreviewModel>>> getProductList({
    required ESearchRange region,
    EMainCategory? mainCategory,
    ESubCategory? subCategory,
    EChildAge? age,
    int? minPrice,
    int? maxPrice,
    required int page,
  });

  ///
  /// API 106
  Future<ResModel<ProductModel>> getProduct({
    required int productId,
  });

  ///
  /// API 107
  Future<ResModel<void>> postProductHeart({
    required int productId,
  });

  ///
  /// API 108
  Future<ResModel<void>> deleteProductHeart({
    required int productId,
  });

  ///
  /// API 109
  Future<ResModel<int>> postProduct({
    required ProductModel product,
  });

  ///
  /// API 110
  Future<ResModel<int>> patchProduct({
    required ProductModel product,
  });

  ///
  /// API 111
  Future<ResModel<void>> postProductState({
    required int productId,
    required EProductSaleState state,
    int? saledUserId,
  });

  ///
  /// API 112
  Future<ResModel<List<UserProfileModel>>> getProductBuyer({
    required int productId,
  });
}
