import 'package:child_goods_store_flutter/interceptors/auth_interceptor.dart';
import 'package:child_goods_store_flutter/models/child/child_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/utils/mock_dio_exception.dart';
import 'package:dio/dio.dart';

class ChildRepository {
  Future<ResModel<List<ChildModel>>> getChild() async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.get('/child');

    // TODO: app connect
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<List<ChildModel>>(
      code: 1000,
      data: [
        ChildModel(
          childId: 1,
          name: '민준',
          age: 12,
          gender: 'M',
          childImg:
              'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
          tag: ['파란색', '편한'],
        ),
        ChildModel(
          childId: 2,
          name: '이현',
          age: 12,
          gender: 'W',
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
          .map((essay) => ChildModel.fromJson(essay))
          .toList(),
    );

    return res;
  }
}
