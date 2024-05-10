import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:child_goods_store_flutter/interceptors/auth_interceptor.dart';
import 'package:child_goods_store_flutter/interceptors/un_auth_interceptor.dart';
import 'package:child_goods_store_flutter/models/product/product_preview_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/purchase/purchase_model.dart';
import 'package:child_goods_store_flutter/models/together/together_preview_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/profile_repository_interface.dart';
import 'package:dio/dio.dart';

class ProfileRepositoryImplProd implements IProfileRepository {
  ///
  /// API 103
  @override
  Future<ResModel<List<ProductPreviewModel>>> getProfileProductList({
    required int userId,
    required int page,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(UnAuthInterceptor());
    var res = await dio.get(
      '/profile/product/$userId',
      queryParameters: {
        'page': page,
      },
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
  /// API 104
  @override
  Future<ResModel<List<ProductPreviewModel>>> getProfileProductHeartList({
    required int page,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.get(
      '/profile/product/heart',
      queryParameters: {
        'page': page,
      },
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
  /// API 105
  @override
  Future<ResModel<List<PurchaseModel>>> getProfileProductPurchaseList({
    required int page,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.get(
      '/profile/product/purchase',
      queryParameters: {
        'page': page,
      },
    );

    var resModel = ResModel<List<PurchaseModel>>.fromJson(
      res.data,
      (json) => (json as List<dynamic>)
          .map((prod) => PurchaseModel.fromJson(prod))
          .toList(),
    );

    return resModel;
  }

  ///
  /// API 202
  @override
  Future<ResModel<List<TogetherPreviewModel>>> getProfileTogetherList({
    required int userId,
    required int page,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(UnAuthInterceptor());
    // dio.get(
    //   '/profile/together/$userId',
    //   queryParameters: {
    //     'page': page,
    //   },
    // );

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<List<TogetherPreviewModel>>(
      code: 1000,
      data: [
        for (var togetherId in List.generate(10, (index) => index + 1))
          TogetherPreviewModel(
            togetherId: togetherId,
            togetherName: '$togetherId th Together',
            totalPrice: 120000,
            purchasePrice: 1200,
            totalNum: 100,
            purchaseNum: 6 * togetherId,
            deadline: DateTime.now(),
            togetherImage: togetherId % 3 == 0
                ? ''
                : 'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
            togetherHeart: togetherId % 3 == 0 ? false : true,
          ),
      ],
    ).toJson(
      (togethers) => togethers.map((tgd) => tgd.toJson()).toList(),
    );

    var res = ResModel<List<TogetherPreviewModel>>.fromJson(
      resTmp,
      (json) => (json as List<dynamic>)
          .map((prod) => TogetherPreviewModel.fromJson(prod))
          .toList(),
    );

    return res;
  }

  ///
  /// API 203
  @override
  Future<ResModel<List<TogetherPreviewModel>>> getProfileTogetherHeartList({
    required int page,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.get(
    //   '/profile/together/heart',
    //   queryParameters: {
    //     'page': page,
    //   },
    // );

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<List<TogetherPreviewModel>>(
      code: 1000,
      data: [
        for (var togetherId in List.generate(10, (index) => index + 1))
          TogetherPreviewModel(
            togetherId: togetherId,
            togetherName: '$togetherId th Together',
            totalPrice: 120000,
            purchasePrice: 1200,
            totalNum: 100,
            purchaseNum: 6 * togetherId,
            deadline: DateTime.now(),
            togetherImage: togetherId % 3 == 0
                ? ''
                : 'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
            togetherHeart: true,
          ),
      ],
    ).toJson(
      (togethers) => togethers.map((tgd) => tgd.toJson()).toList(),
    );

    var res = ResModel<List<TogetherPreviewModel>>.fromJson(
      resTmp,
      (json) => (json as List<dynamic>)
          .map((prod) => TogetherPreviewModel.fromJson(prod))
          .toList(),
    );

    return res;
  }

  ///
  /// API 204
  @override
  Future<ResModel<List<PurchaseModel>>> getProfileTogetherPurchaseList({
    required int page,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.get(
    //   '/profile/together/purchase',
    //   queryParameters: {
    //     'page': page,
    //   },
    // );

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<List<PurchaseModel>>(
      code: 1000,
      data: [
        for (var togetherId in List.generate(10, (index) => index + 1))
          PurchaseModel(
            category: EChatItemType.together,
            id: togetherId,
            title: '$togetherId name',
            sellerName: '$togetherId saller name',
            price: 10000,
            saleCompleteDate: DateTime.now(),
            image: togetherId % 4 == 0
                ? ''
                : 'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
            isReview: togetherId % 3 == 0 ? false : true,
          ),
      ],
    ).toJson(
      (products) => products.map((prod) => prod.toJson()).toList(),
    );

    var res = ResModel<List<PurchaseModel>>.fromJson(
      resTmp,
      (json) => (json as List<dynamic>)
          .map((prod) => PurchaseModel.fromJson(prod))
          .toList(),
    );

    return res;
  }
}
