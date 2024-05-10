import 'package:child_goods_store_flutter/models/res/res_model.dart';

abstract interface class ISearchRepository {
  ///
  /// API 24
  Future<ResModel<List<String>>> seatchTag({
    required String query,
  });
}
