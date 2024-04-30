import 'dart:convert';
import 'package:child_goods_store_flutter/interceptors/auth_interceptor.dart';
import 'package:child_goods_store_flutter/models/address/address_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/data_repository_interface.dart';
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
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.get('/address');

    var resModel = ResModel<List<AddressModel>>.fromJson(
      res.data,
      (json) => (json as List<dynamic>)
          .map((address) => AddressModel.fromJson(address))
          .toList(),
    );

    return resModel;
  }

  ///
  /// API 18
  @override
  Future<ResModel<AddressModel>> postAddress({
    required AddressModel address,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.post(
      '/address',
      data: address.toJson(),
    );

    var resModel = ResModel<AddressModel>.fromJson(
      res.data,
      (json) => AddressModel.fromJson(json),
    );

    return resModel;
  }

  ///
  /// API 19
  @override
  Future<ResModel<AddressModel>> patchAddress({
    required AddressModel address,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.patch(
      '/address',
      queryParameters: {
        'addressId': address.addressId,
      },
      data: address.toJson(),
    );

    var resModel = ResModel<AddressModel>.fromJson(
      res.data,
      (json) => AddressModel.fromJson(json),
    );

    return resModel;
  }
}
