import 'package:child_goods_store_flutter/interceptors/auth_interceptor.dart';
import 'package:child_goods_store_flutter/interceptors/un_auth_interceptor.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/user/user_model.dart';
import 'package:child_goods_store_flutter/models/user/user_profile_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/user_repository_interface.dart';
import 'package:dio/dio.dart';

class UserRepositoryImplProd implements IUserRepository {
  ///
  /// API 6
  @override
  Future<ResModel<UserModel>> getUser() async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.get('/user');

    var resModel = ResModel<UserModel>.fromJson(
      res.data,
      (json) => UserModel.fromJson(json),
    );

    return resModel;
  }

  ///
  /// API 7
  @override
  Future<ResModel<UserModel>> postUser({
    required UserModel user,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.post(
      '/user',
      data: user.toJson(),
    );

    var resModel = ResModel<UserModel>.fromJson(
      res.data,
      (json) => UserModel.fromJson(json),
    );

    return resModel;
  }

  ///
  /// API 8
  @override
  Future<ResModel<UserModel>> patchUser({
    required UserModel user,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.patch(
      '/user',
      data: user.toJson(),
    );

    var resModel = ResModel<UserModel>.fromJson(
      res.data,
      (json) => UserModel.fromJson(json),
    );

    return resModel;
  }

  ///
  /// API 9
  @override
  Future<ResModel<UserProfileModel>> getMyProfile() async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.get('/user/profile');

    print(res.data);

    var resModel = ResModel<UserProfileModel>.fromJson(
      res.data,
      (json) => UserProfileModel.fromJson(json),
    );

    return resModel;
  }

  ///
  /// API 10
  @override
  Future<ResModel<UserProfileModel>> getUserProfile({
    required int userId,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.get('/user/profile/$userId');

    var resModel = ResModel<UserProfileModel>.fromJson(
      res.data,
      (json) => UserProfileModel.fromJson(json),
    );

    return resModel;
  }

  ///
  /// API 20
  @override
  Future<ResModel<List<UserModel>>> getUserFollower({
    required int userId,
    required int page,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(UnAuthInterceptor());
    var res = await dio.get(
      '/user/follower/$userId',
      queryParameters: {
        'page': page,
      },
    );

    var resModel = ResModel<List<UserModel>>.fromJson(
      res.data,
      (json) => (json as List<dynamic>)
          .map((user) => UserModel.fromJson(user))
          .toList(),
    );

    return resModel;
  }

  ///
  /// API 21
  @override
  Future<ResModel<List<UserModel>>> getUserFollowing({
    required int userId,
    required int page,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(UnAuthInterceptor());
    var res = await dio.get(
      '/user/following/$userId',
      queryParameters: {
        'page': page,
      },
    );

    var resModel = ResModel<List<UserModel>>.fromJson(
      res.data,
      (json) => (json as List<dynamic>)
          .map((user) => UserModel.fromJson(user))
          .toList(),
    );

    return resModel;
  }

  ///
  /// API 23
  @override
  Future<ResModel<void>> deleteUser() async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.delete('/user');

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel(code: 1000).toJson((p0) => null);

    var res = ResModel.fromJson(resTmp, (json) => null);

    return res;
  }

  ///
  /// API 25
  @override
  Future<ResModel<void>> postUserFollow({
    required int followId,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.post('/user/follow/$followId');

    var resModel = ResModel.fromJson(
      res.data,
      (json) => null,
    );

    return resModel;
  }

  ///
  /// API 26
  @override
  Future<ResModel<void>> deleteUserFollow({
    required int followId,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor());
    var res = await dio.delete('/user/follow/$followId');

    var resModel = ResModel.fromJson(
      res.data,
      (json) => null,
    );

    return resModel;
  }
}
