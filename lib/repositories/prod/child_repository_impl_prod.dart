import 'package:child_goods_store_flutter/enums/product_sale_state.dart';
import 'package:child_goods_store_flutter/interceptors/auth_interceptor.dart';
import 'package:child_goods_store_flutter/models/child/child_model.dart';
import 'package:child_goods_store_flutter/models/product/product_preview_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/child_repository_interface.dart';
import 'package:dio/dio.dart';

class ChildRepositoryImplProd implements IChildRepository {
  ///
  /// API 11
  @override
  Future<ResModel<List<ChildModel>>> getChild() async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.get('/child');

    var resModel = ResModel<List<ChildModel>>.fromJson(
      res.data,
      (json) => (json as List<dynamic>)
          .map((child) => ChildModel.fromJson(child))
          .toList(),
    );

    return resModel;
  }

  ///
  /// API 12
  @override
  Future<ResModel<ChildModel>> postChild({
    required ChildModel child,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.post(
      '/child',
      data: child.toJson(),
    );

    var resModel = ResModel<ChildModel>.fromJson(
      res.data,
      (json) => ChildModel.fromJson(json),
    );

    return resModel;
  }

  ///
  /// API 13
  @override
  Future<ResModel<ChildModel>> patchChild({
    required ChildModel child,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.patch(
    //   '/child',
    //   data: child.toJson(),
    // );

    // TODO: connect api
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
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.get(
    //   '/child/$childId',
    //   queryParameters: {
    //     'page': page,
    //   },
    // );

    // TODO: connect api
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
