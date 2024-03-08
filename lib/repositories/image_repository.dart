import 'dart:convert';
import 'dart:io';
import 'package:child_goods_store_flutter/interceptors/auth_interceptor.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/utils/mock_dio_exception.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ImageRepository {
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

    // TODO: api connect
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
    String? name,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor(
    //   contentType: 'multipart/form-data',
    // ));
    // // Convert to Multipart
    // List<MultipartFile> mulImages = [];
    // for (int i = 1; i < images.length + 1; i++) {
    //   mulImages.add(await MultipartFile.fromFile(
    //     File(images[i].path).path,
    //     filename: name != null ? '${name}_$i' : images[i].path,
    //   ));
    // }
    // // Create formdata
    // FormData formData = FormData.fromMap({
    //   'files': mulImages,
    // });
    // // Post
    // dio.post(
    //   '/images',
    //   data: formData,
    // );

    // TODO: api connect
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
