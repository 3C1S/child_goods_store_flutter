import 'package:child_goods_store_flutter/models/address/address_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';

abstract interface class IDataRepository {
  Future<Map<String, List<String>>> getAdminDistrict();

  ///
  /// API 17
  Future<ResModel<List<AddressModel>>> getAddress();

  ///
  /// API 18
  Future<ResModel<AddressModel>> postAddress({
    required AddressModel address,
  });

  ///
  /// API 19
  Future<ResModel<AddressModel>> patchAddress({
    required AddressModel address,
  });
}
