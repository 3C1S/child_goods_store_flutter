import 'package:child_goods_store_flutter/enums/child_age.dart';
import 'package:child_goods_store_flutter/enums/child_gender.dart';
import 'package:child_goods_store_flutter/enums/product_sale_state.dart';
import 'package:child_goods_store_flutter/models/child/child_model.dart';
import 'package:child_goods_store_flutter/models/product/product_preview_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/child_repository_interface.dart';

class ChildRepositoryImplDev implements IChildRepository {
  ///
  /// API 11
  @override
  Future<ResModel<List<ChildModel>>> getChild() async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<List<ChildModel>>(
      code: 1000,
      data: [
        ChildModel(
          childId: 1,
          name: '민준',
          age: EChildAge.age12,
          gender: EChildGender.man,
          childImg:
              'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
          tag: ['파란색', '편한', '토이스토리', '로봇', '공룡', '태그 뭐하지', '좀 많으면 어캐될까'],
        ),
        ChildModel(
          childId: 2,
          name: '이현',
          age: EChildAge.age12,
          gender: EChildGender.woman,
          childImg:
              'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
          tag: ['귀여운', '알록달록한', '공주'],
        ),
      ],
    ).toJson(
      (children) => children.map((child) => child.toJson()).toList(),
    );

    var res = ResModel<List<ChildModel>>.fromJson(
      resTmp,
      (json) => (json as List<dynamic>)
          .map((child) => ChildModel.fromJson(child))
          .toList(),
    );

    return res;
  }

  ///
  /// API 12
  @override
  Future<ResModel<ChildModel>> postChild({
    required ChildModel child,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<ChildModel>(
      code: 1000,
      data: ChildModel(
        childId: 999,
        name: child.name,
        age: child.age,
        gender: child.gender,
        childImg: child.childImg,
        tag: child.tag,
      ),
    ).toJson(
      (child) => child.toJson(),
    );

    var res = ResModel<ChildModel>.fromJson(
      resTmp,
      (json) => ChildModel.fromJson(json),
    );

    return res;
  }

  ///
  /// API 13
  @override
  Future<ResModel<ChildModel>> patchChild({
    required ChildModel child,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<ChildModel>(
      code: 1000,
      data: ChildModel(
        childId: child.childId,
        name: child.name,
        age: child.age,
        gender: child.gender,
        childImg: child.childImg,
        tag: child.tag,
      ),
    ).toJson(
      (child) => child.toJson(),
    );

    var res = ResModel<ChildModel>.fromJson(
      resTmp,
      (json) => ChildModel.fromJson(json),
    );

    return res;
  }

  /// API 102
  @override
  Future<ResModel<List<ProductPreviewModel>>> getChildProductList({
    required int childId,
    required int page,
  }) async {
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
}
