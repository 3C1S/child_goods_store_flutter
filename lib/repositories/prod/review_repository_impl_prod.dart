import 'package:child_goods_store_flutter/interceptors/auth_interceptor.dart';
import 'package:child_goods_store_flutter/interceptors/un_auth_interceptor.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/review/review_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/review_repository_interface.dart';
import 'package:dio/dio.dart';

class ReviewRepositoryImplProd implements IReviewRepository {
  ///
  /// API 14
  @override
  Future<ResModel<List<ReviewModel>>> getReviewList({
    required int userId,
    required int page,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(UnAuthInterceptor());
    var res = await dio.get(
      '/review/$userId',
      queryParameters: {
        'page': page,
      },
    );

    var resModel = ResModel<List<ReviewModel>>.fromJson(
      res.data,
      (json) => (json as List<dynamic>)
          .map((review) => ReviewModel.fromJson(review))
          .toList(),
    );

    return resModel;
  }

  ///
  /// API 15
  @override
  Future<ResModel<void>> postReview({
    required ReviewModel review,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.post(
      '/review',
      data: review.toJson(),
    );

    var resModel = ResModel.fromJson(
      res.data,
      (json) => null,
    );

    return resModel;
  }

  ///
  /// API 16
  @override
  Future<ResModel<void>> patchReview({
    required ReviewModel review,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.patch(
      '/review/${review.reviewId}',
      data: review.toJson(),
    );

    var resModel = ResModel.fromJson(
      res.data,
      (json) => null,
    );

    return resModel;
  }

  ///
  /// API 22
  @override
  Future<ResModel<void>> deleteReview({
    required int reviewId,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.delete('/review/$reviewId');

    var resModel = ResModel.fromJson(
      res.data,
      (json) => null,
    );

    return resModel;
  }
}
