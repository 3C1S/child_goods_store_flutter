import 'package:child_goods_store_flutter/enums/child_age.dart';
import 'package:child_goods_store_flutter/enums/main_category.dart';
import 'package:child_goods_store_flutter/enums/product_sale_state.dart';
import 'package:child_goods_store_flutter/enums/product_state.dart';
import 'package:child_goods_store_flutter/enums/search_range.dart';
import 'package:child_goods_store_flutter/enums/sub_category.dart';
import 'package:child_goods_store_flutter/models/product/product_model.dart';
import 'package:child_goods_store_flutter/models/product/product_preview_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/user/user_profile_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/product_repository_interfave.dart';

class ProductRepositoryImplDev implements IProductRepository {
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

    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<List<ProductPreviewModel>>(
      code: 1000,
      data: [
        for (var productId in List.generate(10, (index) => index + 1))
          ProductPreviewModel(
            productId: productId,
            productName: '$productId th product',
            price: 12000,
            state: EProductSaleState.sale,
            productImage: productId % 3 == 0
                ? ''
                : 'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
            productHeart: productId % 3 == 0 ? false : true,
          ),
      ],
    ).toJson(
      (products) => products.map((prod) => prod.toJson()).toList(),
    );

    var res = ResModel<List<ProductPreviewModel>>.fromJson(
      resTmp,
      (json) => (json as List<dynamic>)
          .map((prod) => ProductPreviewModel.fromJson(prod))
          .toList(),
    );

    return res;
  }

  ///
  /// API 106
  @override
  Future<ResModel<ProductModel>> getProduct({
    required int productId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<ProductModel>(
      code: 1000,
      data: ProductModel(
        productId: productId,
        user: UserProfileModel(
          userId: productId, // 분기
          nickName: 'product $productId saler',
          averageStars: 4.5,
        ),
        productName: '$productId th product',
        price: 12000,
        content: '$productId th product contents',
        mainCategory: EMainCategory.clothing,
        subCategory: ESubCategory.manTop,
        productState: EProductState.littleUsage,
        state: EProductSaleState.sale,
        age: EChildAge.age24,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        tag: List.generate(3, (index) => '$productId-$index tag'),
        productImage: [
          'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
          'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
          'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
        ],
        productHeart: false,
      ),
    ).toJson((product) => product.toJson());

    var res = ResModel<ProductModel>.fromJson(
      resTmp,
      (json) => ProductModel.fromJson(json),
    );

    return res;
  }

  ///
  /// API 107
  @override
  Future<ResModel<void>> postProductHeart({
    required int productId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel(code: 1000).toJson((p0) => null);

    var res = ResModel.fromJson(resTmp, (json) => null);

    return res;
  }

  ///
  /// API 108
  @override
  Future<ResModel<void>> deleteProductHeart({
    required int productId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel(code: 1000).toJson((p0) => null);

    var res = ResModel.fromJson(resTmp, (json) => null);

    return res;
  }

  ///
  /// API 109
  @override
  Future<ResModel<int>> postProduct({
    required ProductModel product,
  }) async {
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

  ///
  /// API 110
  @override
  Future<ResModel<int>> patchProduct({
    required ProductModel product,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<int>(
      code: 1000,
      data: product.productId,
    ).toJson(
      (id) => id.toString(),
    );

    var res = ResModel<int>.fromJson(
      resTmp,
      (json) => int.parse(json),
    );

    return res;
  }

  ///
  /// API 111
  @override
  Future<ResModel<void>> postProductState({
    required int productId,
    required EProductSaleState state,
    int? saledUserId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel(code: 1000).toJson((p0) => null);

    var res = ResModel.fromJson(resTmp, (json) => null);

    return res;
  }

  ///
  /// API 112
  @override
  Future<ResModel<List<UserProfileModel>>> getProductBuyer({
    required int productId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<List<UserProfileModel>>(
      code: 1000,
      data: [
        UserProfileModel(
          userId: 100,
          profileImg:
              'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
          nickName: '구매자1',
        ),
        UserProfileModel(
          userId: 101,
          profileImg: '',
          nickName: '구매자2',
        ),
        UserProfileModel(
          userId: 102,
          nickName: '구매자3',
        ),
      ],
    ).toJson(
      (users) => users.map((user) => user.toJson()).toList(),
    );

    var res = ResModel<List<UserProfileModel>>.fromJson(
      resTmp,
      (json) => (json as List<dynamic>)
          .map((user) => UserProfileModel.fromJson(user))
          .toList(),
    );

    return res;
  }
}
