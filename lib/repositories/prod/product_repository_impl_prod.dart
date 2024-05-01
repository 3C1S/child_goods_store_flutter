import 'package:child_goods_store_flutter/enums/child_age.dart';
import 'package:child_goods_store_flutter/enums/main_category.dart';
import 'package:child_goods_store_flutter/enums/product_sale_state.dart';
import 'package:child_goods_store_flutter/enums/search_range.dart';
import 'package:child_goods_store_flutter/enums/sub_category.dart';
import 'package:child_goods_store_flutter/interceptors/auth_interceptor.dart';
import 'package:child_goods_store_flutter/models/product/product_model.dart';
import 'package:child_goods_store_flutter/models/product/product_preview_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/user/user_profile_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/product_repository_interfave.dart';
import 'package:dio/dio.dart';

class ProductRepositoryImplProd implements IProductRepository {
  ///
  /// API 101
  @override
  Future<ResModel<List<ProductPreviewModel>>> getProductList({
    required ESearchRange region,
    EMainCategory? mainCategory,
    ESubCategory? subCategory,
    EChildAge? age,
    int? minPrice,
    int? maxPrice,
    required int page,
  }) async {
    Map<String, dynamic> queryParams = {};
    queryParams['page'] = page;
    queryParams['region'] = region.key;
    if (mainCategory != null) {
      queryParams['mainCategory'] = mainCategory.key;
    }
    if (subCategory != null) {
      queryParams['subCategory'] = subCategory.key;
    }
    if (age != null) {
      queryParams['age'] = age.key;
    }
    if (minPrice != null) {
      queryParams['minPrice'] = minPrice;
    }
    if (maxPrice != null) {
      queryParams['maxPrice'] = maxPrice;
    }

    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.get(
      '/product',
      queryParameters: queryParams,
    );

    var resModel = ResModel<List<ProductPreviewModel>>.fromJson(
      res.data,
      (json) => (json as List<dynamic>)
          .map((prod) => ProductPreviewModel.fromJson(prod))
          .toList(),
    );

    return resModel;
  }

  ///
  /// API 106
  @override
  Future<ResModel<ProductModel>> getProduct({
    required int productId,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.get('/product/$productId');

    var resModel = ResModel<ProductModel>.fromJson(
      res.data,
      (json) => ProductModel.fromJson(json),
    );

    return resModel;
  }

  ///
  /// API 107
  @override
  Future<ResModel<void>> postProductHeart({
    required int productId,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.post('/product/heart/$productId');

    var resModel = ResModel.fromJson(
      res.data,
      (json) => null,
    );

    return resModel;
  }

  ///
  /// API 108
  @override
  Future<ResModel<void>> deleteProductHeart({
    required int productId,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.delete('/product/heart/$productId');

    var resModel = ResModel.fromJson(
      res.data,
      (json) => null,
    );

    return resModel;
  }

  ///
  /// API 109
  @override
  Future<ResModel<int>> postProduct({
    required ProductModel product,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.post(
      '/product',
      data: product.toJson(),
    );

    var resModel = ResModel<int>.fromJson(
      res.data,
      (json) => json as int,
    );

    return resModel;
  }

  ///
  /// API 110
  @override
  Future<ResModel<int>> patchProduct({
    required ProductModel product,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.patch(
      '/product/${product.productId}',
      data: product.toJson(),
    );

    var resModel = ResModel<int>.fromJson(
      res.data,
      (json) => json as int,
    );

    return resModel;
  }

  ///
  /// API 111
  @override
  Future<ResModel<void>> postProductState({
    required int productId,
    required EProductSaleState state,
    int? saledUserId,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.post(
      '/product/state/$productId',
      data: {
        'state': state.key,
        'userId': saledUserId ?? -1,
      },
    );

    var resModel = ResModel.fromJson(
      res.data,
      (json) => null,
    );

    return resModel;
  }

  ///
  /// API 112
  @override
  Future<ResModel<List<UserProfileModel>>> getProductBuyer({
    required int productId,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.get('/product/buyer/$productId');

    var resModel = ResModel<List<UserProfileModel>>.fromJson(
      res.data,
      (json) => (json as List<dynamic>)
          .map((user) => UserProfileModel.fromJson(user))
          .toList(),
    );

    return resModel;
  }
}
