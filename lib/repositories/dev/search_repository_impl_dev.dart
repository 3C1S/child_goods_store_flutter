import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/search_repository_interface.dart';

class SearchRepositoryimplDev implements ISearchRepository {
  ///
  /// API 24
  @override
  Future<ResModel<List<String>>> seatchTag({
    required String query,
  }) async {
    var resTmp = ResModel<List<String>>(
      code: 1000,
      data: [for (int i = 0; i < 5; i++) "$query $i"],
    ).toJson(
      (children) => children.map((tag) => tag).toList(),
    );

    var res = ResModel<List<String>>.fromJson(
      resTmp,
      (json) =>
          (json as List<dynamic>).map((child) => child as String).toList(),
    );

    return res;
  }
}
