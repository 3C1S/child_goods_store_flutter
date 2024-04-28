import 'package:child_goods_store_flutter/enums/image_category.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:image_picker/image_picker.dart';

abstract interface class IImageRepository {
  @Deprecated('Using postImageList instead')
  Future<ResModel<String>> postImage({
    required XFile image,
    String? name,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor(
    //   contentType: 'multipart/form-data',
    // ));
    // // Convert to Multipart
    // MultipartFile mulImage = await MultipartFile.fromFile(
    //   File(image.path).path,
    //   filename: name ?? image.path,
    // );
    // // Create formdata
    // FormData formData = FormData.fromMap({
    //   'file': mulImage,
    // });
    // // Post
    // dio.post(
    //   '/image',
    //   data: formData,
    // );

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

  Future<ResModel<List<String>>> postImageList({
    required List<XFile> images,
    required EImageCategory category,
    String? name,
  });
}
