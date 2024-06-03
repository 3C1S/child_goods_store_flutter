import 'package:child_goods_store_flutter/enums/child_age.dart';
import 'package:child_goods_store_flutter/enums/main_category.dart';
import 'package:child_goods_store_flutter/enums/product_sale_state.dart';
import 'package:child_goods_store_flutter/enums/search_range.dart';
import 'package:child_goods_store_flutter/enums/sub_category.dart';
import 'package:child_goods_store_flutter/interceptors/auth_interceptor.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/together/together_model.dart';
import 'package:child_goods_store_flutter/models/together/together_preview_model.dart';
import 'package:child_goods_store_flutter/models/user/user_profile_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/together_repository_interface.dart';
import 'package:dio/dio.dart';

class TogetherRepositoryImplProd implements ITogetherRepository {
  ///
  /// API 201
  @override
  Future<ResModel<List<TogetherPreviewModel>>> getTogetherList({
    required ESearchRange region,
    EMainCategory? mainCategory,
    ESubCategory? subCategory,
    EChildAge? age,
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

    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.get(
    //   '/together',
    //   queryParameters: queryParams,
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
  /// API 205
  @override
  Future<ResModel<TogetherModel>> getTogether({
    required int togetherId,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.get('/together/$togetherId');

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<TogetherModel>(
      code: 1000,
      data: TogetherModel(
        togetherId: togetherId,
        user: UserProfileModel(
          userId: 1, // 분기
          nickName: 'together $togetherId opener',
          averageStars: 4.5,
        ),
        togetherName: '$togetherId th together',
        totalPrice: 100000,
        purchasePrice: 1000,
        mainCategory: EMainCategory.clothing,
        subCategory: ESubCategory.womanBottom,
        state: EProductSaleState.sale,
        age: EChildAge.age24,
        details: '$togetherId th together details',
        link: 'https://www.google.com',
        deadline: DateTime.now(),
        address: '서울특별시 노원구 광운로',
        detailAddress: '새빛관 1층',
        totalNum: 100,
        purchaseNum: 50,
        tag: List.generate(3, (index) => '$togetherId-$index tag'),
        togetherImage: [
          'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
          'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
          'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
        ],
        togetherHeart: false,
      ),
    ).toJson((together) => together.toJson());

    var res = ResModel<TogetherModel>.fromJson(
      resTmp,
      (json) => TogetherModel.fromJson(json),
    );

    return res;
  }

  ///
  ///  API 206
  @override
  Future<ResModel<void>> postTogetherHeart({
    required int togetherId,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.post(
    //   '/together/heart',
    //   data: {
    //     'togetherId': togetherId,
    //   },
    // );

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel(code: 1000).toJson((p0) => null);

    var res = ResModel.fromJson(resTmp, (json) => null);

    return res;
  }

  ///
  /// API 207
  @override
  Future<ResModel<void>> deleteTogetherHeart({
    required int togetherId,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.delete('/together/heart/$togetherId');

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel(code: 1000).toJson((p0) => null);

    var res = ResModel.fromJson(resTmp, (json) => null);

    return res;
  }

  /// API 208
  @override
  Future<ResModel<int>> postTogether({
    required TogetherModel together,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.post(
    //   '/together',
    //   data: together.toJson(),
    // );

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<int>(
      code: 1000,
      data: 999,
    ).toJson(
      (id) => id.toString(),
    );

    var res = ResModel<int>.fromJson(
      resTmp,
      (json) => int.parse(json),
    );

    return res;
  }

  /// API 209
  @override
  Future<ResModel<int>> patchTogether({
    required TogetherModel together,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.post(
    //   '/together/${together.togetherId}',
    //   data: together.toJson(),
    // );

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<int>(
      code: 1000,
      data: together.togetherId,
    ).toJson(
      (id) => id.toString(),
    );

    var res = ResModel<int>.fromJson(
      resTmp,
      (json) => int.parse(json),
    );

    return res;
  }
}
