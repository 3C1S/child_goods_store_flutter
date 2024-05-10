import 'dart:convert';
import 'package:child_goods_store_flutter/enums/image_category.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/image_repository_interface.dart';
import 'package:image_picker/image_picker.dart';

class ImageRepositoryImplDev implements IImageRepository {
  @override
  Future<ResModel<String>> postImage({
    required XFile image,
    String? name,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<String>(
      code: 1000,
      data:
          "https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR",
    ).toJson((imgStr) => imgStr);

    var res = ResModel<String>.fromJson(
      resTmp,
      (json) => json.toString(),
    );

    return res;
  }

  @override
  Future<ResModel<List<String>>> postImageList({
    required List<XFile> images,
    required EImageCategory category,
    String? name,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<List<String>>(
      code: 1000,
      data: [
        for (var _ in images)
          "https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR",
      ],
    ).toJson((imgStr) => jsonEncode(imgStr));

    var res = ResModel<List<String>>.fromJson(
      resTmp,
      (json) => (jsonDecode(json) as List<dynamic>).cast<String>(),
    );

    return res;
  }
}
