import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/interceptors/auth_interceptor.dart';
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
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.get('/user/profile');

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<UserProfileModel>(
      code: 1000,
      data: UserProfileModel(
        userId: AuthBlocSingleton.bloc.state.user?.userId,
        nickName: AuthBlocSingleton.bloc.state.user?.nickName,
        profileImg: AuthBlocSingleton.bloc.state.user?.profileImg,
        introduce: AuthBlocSingleton.bloc.state.user?.introduce,
        followNum: 10,
        followingNum: 20,
        averageStars: 4.5,
        createdAt: DateTime.now(),
      ),
    ).toJson(
      (userProfile) => userProfile.toJson(),
    );

    var res = ResModel<UserProfileModel>.fromJson(
      resTmp,
      (json) => UserProfileModel.fromJson(json),
    );

    return res;
  }

  ///
  /// API 10
  @override
  Future<ResModel<UserProfileModel>> getUserProfile({
    required int userId,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(AuthInterceptor());
    // dio.get('/user/profile/$userId');

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<UserProfileModel>(
      code: 1000,
      data: UserProfileModel(
        userId: userId,
        nickName: 'extra user $userId',
        profileImg:
            'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
        introduce: 'hello flutter',
        followNum: 10,
        followingNum: 20,
        averageStars: 4.5,
        createdAt: DateTime.now(),
      ),
    ).toJson(
      (userProfile) => userProfile.toJson(),
    );

    var res = ResModel<UserProfileModel>.fromJson(
      resTmp,
      (json) => UserProfileModel.fromJson(json),
    );

    return res;
  }

  ///
  /// API 20
  @override
  Future<ResModel<List<UserModel>>> getUserFollower({
    required int userId,
    required int page,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(UnAuthInterceptor());
    // dio.get(
    //   '/user/follower/$userId',
    //   queryParameters: {
    //     'page': page,
    //   },
    // );

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<List<UserModel>>(
      code: 1000,
      data: [
        UserModel(
          userId: 100,
          profileImg:
              'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
          nickName: '팔로워1',
        ),
        UserModel(
          userId: 101,
          profileImg: '',
          nickName: '팔로워2',
        ),
        UserModel(
          userId: 102,
          nickName: '팔로워3',
        ),
      ],
    ).toJson(
      (users) => users.map((user) => user.toJson()).toList(),
    );

    var res = ResModel<List<UserModel>>.fromJson(
      resTmp,
      (json) => (json as List<dynamic>)
          .map((user) => UserModel.fromJson(user))
          .toList(),
    );

    return res;
  }

  ///
  /// API 21
  @override
  Future<ResModel<List<UserModel>>> getUserFollowing({
    required int userId,
    required int page,
  }) async {
    // Dio dio = Dio();
    // dio.interceptors.add(UnAuthInterceptor());
    // dio.get(
    //   '/user/following/$userId',
    //   queryParameters: {
    //     'page': page,
    //   },
    // );

    // TODO: connect api
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<List<UserModel>>(
      code: 1000,
      data: [
        UserModel(
          userId: 100,
          profileImg:
              'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
          nickName: '팔로잉1',
        ),
        UserModel(
          userId: 101,
          profileImg: '',
          nickName: '팔로잉2',
        ),
        UserModel(
          userId: 102,
          nickName: '팔로잉3',
        ),
      ],
    ).toJson(
      (users) => users.map((user) => user.toJson()).toList(),
    );

    var res = ResModel<List<UserModel>>.fromJson(
      resTmp,
      (json) => (json as List<dynamic>)
          .map((user) => UserModel.fromJson(user))
          .toList(),
    );

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
