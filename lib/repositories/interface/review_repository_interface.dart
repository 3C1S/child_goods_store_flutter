import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/review/review_model.dart';

abstract interface class IReviewRepository {
  ///
  /// API 14
  Future<ResModel<List<ReviewModel>>> getReviewList({
    required int userId,
    required int page,
  });

  ///
  /// API 15
  Future<ResModel<void>> postReview({
    required ReviewModel review,
  });

  ///
  /// API 16
  Future<ResModel<void>> patchReview({
    required ReviewModel review,
  });

  ///
  /// API 22
  Future<ResModel<void>> deleteReview({
    required int reviewId,
  });
}
