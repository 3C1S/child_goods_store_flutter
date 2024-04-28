import 'dart:convert';
import 'package:child_goods_store_flutter/enums/address_category.dart';
import 'package:child_goods_store_flutter/interceptors/auth_interceptor.dart';
import 'package:child_goods_store_flutter/models/address/address_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/data_repository_interface.dart';
import 'package:child_goods_store_flutter/utils/mock_dio_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class DataRepositoryImplProd implements IDataRepository {
  @override
  Future<Map<String, List<String>>> getAdminDistrict() async {
    // Get json data
    var jsonStr = await rootBundle
        .loadString('assets/jsons/korea-administrative-district.json');
    Map<String, List<String>> districtData = {};
    // Deserialize
    var jsonData = await json.decode(jsonStr)['data'] as List<dynamic>;
    for (var data in jsonData) {
      var cast = data as Map<String, dynamic>;
      String key = cast.keys.first;
      List<String> values = List<String>.from(cast[key] as List<dynamic>);
      districtData[key] = values;
    }

    return districtData;
  }

  ///
  /// API 17
  @override
  Future<ResModel<List<AddressModel>>> getAddress() async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.get('/address');

    // TODO: connect api
    var resTmp = ResModel<List<AddressModel>>(
      code: 1000,
      data: [
        AddressModel(
          addressId: 1,
          address: '서울특별시 성동구 왕십리로 16 (성수동1가, 트리마제) 주소가 너무 길다면 어떻게 될까',
          detailAddress: '100동 200호',
          category: EAddressCategory.home,
        ),
        AddressModel(
          addressId: 2,
          address: '서울특별시 노원구',
          detailAddress: '새빛관 1층',
          category: EAddressCategory.school,
        ),
      ],
    ).toJson(
      (addresses) => addresses.map((address) => address.toJson()).toList(),
    );

    var res = ResModel<List<AddressModel>>.fromJson(
      resTmp,
      (json) => (json as List<dynamic>)
          .map((address) => AddressModel.fromJson(address))
          .toList(),
    );

    return res;
  }

  ///
  /// API 18
  @override
  Future<ResModel<AddressModel>> postAddress({
    required AddressModel address,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.post(
    //   '/address',
    //   data: address.toJson(),
    // );

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<AddressModel>(
      code: 1000,
      data: AddressModel(
        addressId: 999,
        address: address.address,
        detailAddress: address.detailAddress,
        category: address.category,
      ),
    ).toJson((address) => address.toJson());

    var res = ResModel<AddressModel>.fromJson(
      resTmp,
      (json) => AddressModel.fromJson(json),
    );

    return res;
  }

  ///
  /// API 19
  @override
  Future<ResModel<AddressModel>> patchAddress({
    required AddressModel address,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.patch(
    //   '/address',
    //   queryParameters: {
    //     'addressId': address.addressId,
    //   },
    //   data: address.toJson(),
    // );

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<AddressModel>(
      code: 1000,
      data: address,
    ).toJson((address) => address.toJson());

    var res = ResModel<AddressModel>.fromJson(
      resTmp,
      (json) => AddressModel.fromJson(json),
    );

    return res;
  }
}
