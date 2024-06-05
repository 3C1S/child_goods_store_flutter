import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/user/user_model.dart';
import 'package:child_goods_store_flutter/models/user/user_profile_model.dart';

abstract interface class IUserRepository {
  ///
  /// API 6
  Future<ResModel<UserModel>> getUser();

  ///
  /// API 7
  Future<ResModel<UserModel>> postUser({
    required UserModel user,
  });

  ///
  /// API 8
  Future<ResModel<UserModel>> patchUser({
    required UserModel user,
  });

  ///
  /// API 9
  Future<ResModel<UserProfileModel>> getMyProfile();

  ///
  /// API 10
  Future<ResModel<UserProfileModel>> getUserProfile({
    required int userId,
  });

  ///
  /// API 20
  Future<ResModel<List<UserModel>>> getUserFollower({
    required int userId,
    required int page,
  });

  ///
  /// API 21
  Future<ResModel<List<UserModel>>> getUserFollowing({
    required int userId,
    required int page,
  });

  ///
  /// API 23
  Future<ResModel<void>> deleteUser();

  ///
  /// API 25
  Future<ResModel<void>> postUserFollow({
    required int followId,
  });

  ///
  /// API 26
  Future<ResModel<void>> deleteUserFollow({
    required int followId,
  });
}
