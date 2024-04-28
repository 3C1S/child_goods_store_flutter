import 'package:child_goods_store_flutter/enums/child_age.dart';
import 'package:child_goods_store_flutter/enums/main_category.dart';
import 'package:child_goods_store_flutter/enums/search_range.dart';
import 'package:child_goods_store_flutter/enums/sub_category.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/together/together_model.dart';
import 'package:child_goods_store_flutter/models/together/together_preview_model.dart';

abstract interface class ITogetherRepository {
  ///
  /// API 201
  Future<ResModel<List<TogetherPreviewModel>>> getTogetherList({
    required ESearchRange region,
    EMainCategory? mainCategory,
    ESubCategory? subCategory,
    EChildAge? age,
    required int page,
  });

  ///
  /// API 205
  Future<ResModel<TogetherModel>> getTogether({
    required int togetherId,
  });

  ///
  ///  API 206
  Future<ResModel<void>> postTogetherHeart({
    required int togetherId,
  });

  ///
  /// API 207
  Future<ResModel<void>> deleteTogetherHeart({
    required int togetherId,
  });

  /// API 208
  Future<ResModel<int>> postTogether({
    required TogetherModel together,
  });

  /// API 209
  Future<ResModel<int>> patchTogether({
    required TogetherModel together,
  });
}
